#!/bin/sh

if [ "$1" = "travis" ]; then
    psql -U postgres -c "CREATE DATABASE t2reca_test;"
    psql -U postgres -c "CREATE USER t2reca PASSWORD 't2reca' SUPERUSER;"
else
    [ "$1" = "test" ] || sudo -u postgres dropdb --if-exists t2reca
    sudo -u postgres dropdb --if-exists t2reca_test
    [ "$1" = "test" ] || sudo -u postgres dropuser --if-exists t2reca
    [ "$1" = "test" ] || sudo -u postgres psql -c "CREATE USER t2reca PASSWORD 't2reca' SUPERUSER;"
    [ "$1" = "test" ] || sudo -u postgres createdb -O t2reca t2reca
    [ "$1" = "test" ] || sudo -u postgres psql -d t2reca -c "CREATE EXTENSION pgcrypto;" 2>/dev/null
    sudo -u postgres createdb -O t2reca t2reca_test
    sudo -u postgres psql -d t2reca_test -c "CREATE EXTENSION pgcrypto;" 2>/dev/null
    [ "$1" = "test" ] && exit
    LINE="localhost:5432:*:t2reca:t2reca"
    FILE=~/.pgpass
    if [ ! -f $FILE ]; then
        touch $FILE
        chmod 600 $FILE
    fi
    if ! grep -qsF "$LINE" $FILE; then
        echo "$LINE" >> $FILE
    fi
fi

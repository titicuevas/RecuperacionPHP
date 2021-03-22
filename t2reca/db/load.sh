#!/bin/sh

BASE_DIR=$(dirname "$(readlink -f "$0")")
if [ "$1" != "test" ]; then
    psql -h localhost -U t2reca -d t2reca < $BASE_DIR/t2reca.sql
    if [ -f "$BASE_DIR/t2reca_test.sql" ]; then
        psql -h localhost -U t2reca -d t2reca < $BASE_DIR/t2reca_test.sql
    fi
    echo "DROP TABLE IF EXISTS migration CASCADE;" | psql -h localhost -U t2reca -d t2reca
fi
psql -h localhost -U t2reca -d t2reca_test < $BASE_DIR/t2reca.sql
echo "DROP TABLE IF EXISTS migration CASCADE;" | psql -h localhost -U t2reca -d t2reca_test

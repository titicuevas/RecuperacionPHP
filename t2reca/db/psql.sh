#!/bin/sh

[ "$1" = "test" ] && BD="_test"
psql -h localhost -U t2reca -d t2reca$BD

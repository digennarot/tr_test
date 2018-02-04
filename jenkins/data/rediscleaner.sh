#!/bin/bash

REDIS_CMD="/usr/local/bin/redis-cli"

$REDIS_CMD -p 6379 --raw keys "*" | while read LINE
do
if [ ! -z $LINE ]; then
        val=$($REDIS_CMD -p 6379 --raw object idletime $LINE)
        if [ $val -gt $((30 * 24 * 60 * 60)) ]; then
        	echo "CLEANING " $LINE
          	$REDIS_CMD -p 6379 del $LINE

        fi
else
        exit 0
        echo "Nothing to clean"
fi
done

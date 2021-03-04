#!/bin/bash

redis_pid=$(ps -ef | grep "redis-server" | grep -v "grep" | awk '{ print $2 }')
kill -9 $redis_pid

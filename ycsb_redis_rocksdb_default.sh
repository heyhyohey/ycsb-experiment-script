#!/bin/zsh

if [[ $# -ne 2 ]] ; then
	echo "Usage: $0 [mem_size] [result_directory]"
	exit 1
fi

# redis
./redis_default.sh redis $1 $2
sleep 60

# rocksdb
./rocksdb_default.sh rocksdb $1 $2
sleep 60

echo "All finish!"

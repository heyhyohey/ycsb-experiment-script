#!/bin/zsh

if [[ $# -ne 4 ]] ; then
	echo "Usage: $0 [mem_size] [result_directory] [numa_policy] [numa_nodes]"
	exit 1
fi

# redis
./redis_numa.sh redis $1 $2 $3 $4
sleep 60

# rocksdb
./rocksdb_numa.sh rocksdb $1 $2 $3 $4
sleep 60

echo "All finish!"

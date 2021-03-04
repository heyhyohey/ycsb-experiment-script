#!/bin/zsh

if [[ $# -ne 3 ]] ; then
	echo "Usage: $0 [db] [mem_size] [result_directory]"
	exit 1
fi

echo $1
echo $2
echo $3

redis-server --save "" --appendonly no&
sleep 5

echo "$1_workloada_load" > current.txt
./bin/ycsb load $1 -P ./workloads/workloada -P ./config/$1.prop -p recordcount=45000000 -p operationcount=20000000 -p threadcount=20 -s > ./exp/$3/$1/default-$2-$1-load-workload-a.txt
echo "$1_workloada_run" > current.txt
./bin/ycsb run $1 -P ./workloads/workloada -P ./config/$1.prop -p recordcount=45000000 -p operationcount=20000000 -p threadcount=20 -s > ./exp/$3/$1/default-$2-$1-run-workload-a.txt
echo "$1_workloadb_run" > current.txt
./bin/ycsb run $1 -P ./workloads/workloadb -P ./config/$1.prop -p recordcount=45000000 -p operationcount=20000000 -p threadcount=20 -s > ./exp/$3/$1/default-$2-$1-run-workload-b.txt
echo "$1_workloadc_run" > current.txt
./bin/ycsb run $1 -P ./workloads/workloadc -P ./config/$1.prop -p recordcount=45000000 -p operationcount=20000000 -p threadcount=20 -s > ./exp/$3/$1/default-$2-$1-run-workload-c.txt
echo "$1_workloadf_run" > current.txt
./bin/ycsb run $1 -P ./workloads/workloadf -P ./config/$1.prop -p recordcount=45000000 -p operationcount=20000000 -p threadcount=20 -s > ./exp/$3/$1/default-$2-$1-run-workload-f.txt
echo "$1_workloadd_run" > current.txt
./bin/ycsb run $1 -P ./workloads/workloadd -P ./config/$1.prop -p recordcount=45000000 -p operationcount=20000000 -p threadcount=20 -s > ./exp/$3/$1/default-$2-$1-run-workload-d.txt

./redis_kill.sh
sleep 60
redis-server --save "" --appendonly no&
sleep 5

echo "$1_workloade_load" > current.txt
./bin/ycsb load $1 -P ./workloads/workloade -P ./config/$1.prop -p recordcount=45000000 -p operationcount=20000000 -p threadcount=20 -s > ./exp/$3/$1/default-$2-$1-load-workload-e.txt
echo "$1_workloade_run" > current.txt
./bin/ycsb run $1 -P ./workloads/workloade -P ./config/$1.prop -p recordcount=45000000 -p operationcount=2000000 -p threadcount=20 -s > ./exp/$3/$1/default-$2-$1-run-workload-e.txt

./redis_kill.sh
sleep 5

echo "Finish!"

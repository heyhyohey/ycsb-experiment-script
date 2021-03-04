#!/bin/zsh

if [[ $# -ne 5 ]] ; then
	echo "Usage: $0 [db] [mem_size] [result_directory] [numa_policy] [numa_nodes]"
	exit 1
fi

echo $1
echo $2
echo $3
echo $4
echo $5

echo "$1_workloada_load" > current.txt
numactl --$4=$5 ./bin/ycsb load $1 -P ./workloads/workloada -P ./config/$1.prop -p recordcount=45000000 -p operationcount=30000000 -p threadcount=20 -s > ./exp/$3/$1/$4-$2-$1-load-workload-a.txt
echo "$1_workloada_run" > current.txt
numactl --$4=$5 ./bin/ycsb run $1 -P ./workloads/workloada -P ./config/$1.prop -p recordcount=45000000 -p operationcount=30000000 -p threadcount=20 -s > ./exp/$3/$1/$4-$2-$1-run-workload-a.txt
echo "$1_workloadb_run" > current.txt
numactl --$4=$5 ./bin/ycsb run $1 -P ./workloads/workloadb -P ./config/$1.prop -p recordcount=45000000 -p operationcount=30000000 -p threadcount=20 -s > ./exp/$3/$1/$4-$2-$1-run-workload-b.txt
echo "$1_workloadc_run" > current.txt
numactl --$4=$5 ./bin/ycsb run $1 -P ./workloads/workloadc -P ./config/$1.prop -p recordcount=45000000 -p operationcount=30000000 -p threadcount=20 -s > ./exp/$3/$1/$4-$2-$1-run-workload-c.txt
echo "$1_workloadf_run" > current.txt
numactl --$4=$5 ./bin/ycsb run $1 -P ./workloads/workloadf -P ./config/$1.prop -p recordcount=45000000 -p operationcount=30000000 -p threadcount=20 -s > ./exp/$3/$1/$4-$2-$1-run-workload-f.txt
echo "$1_workloadd_run" > current.txt
numactl --$4=$5 ./bin/ycsb run $1 -P ./workloads/workloadd -P ./config/$1.prop -p recordcount=45000000 -p operationcount=30000000 -p threadcount=20 -s > ./exp/$3/$1/$4-$2-$1-run-workload-d.txt
sleep 5
rm -rf /mnt/nvme/ycsb-rocksdb-data
echo "$1_workloade_load" > current.txt
numactl --$4=$5 ./bin/ycsb load $1 -P ./workloads/workloade -P ./config/$1.prop -p recordcount=45000000 -p operationcount=30000000 -p threadcount=20 -s > ./exp/$3/$1/$4-$2-$1-load-workload-e.txt
echo "$1_workloade_run" > current.txt
numactl --$4=$5 ./bin/ycsb run $1 -P ./workloads/workloade -P ./config/$1.prop -p recordcount=45000000 -p operationcount=3000000 -p threadcount=20 -s > ./exp/$3/$1/$4-$2-$1-run-workload-e.txt
sleep 5
rm -rf /mnt/nvme/ycsb-rocksdb-data
echo "Finish!"

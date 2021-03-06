#!/bin/zsh

if [[ $# -ne 4 ]] ; then
	echo "Usage: $0 [mode] [db] [mem_size] [bind_option]"
	exit 1
fi

echo $1
echo $2
echo $3
echo $4

systemctl restart mongod
sleep 5

echo "$2_workloada_load" > current.txt
./bin/ycsb load $2 -P ./workloads/workloada -p recordcount=50000000 -p operationcount=30000000 -p threadcount=20 -s > ./exp/$4/$2/result_$3/$2-$1-load-workload-a.txt
echo "$2_workloada_run" > current.txt
./bin/ycsb run $2 -P ./workloads/workloada -p recordcount=50000000 -p operationcount=30000000 -p threadcount=20 -s > ./exp/$4/$2/result_$3/$2-$1-run-workload-a.txt
echo "$2_workloadb_run" > current.txt
./bin/ycsb run $2 -P ./workloads/workloadb -p recordcount=50000000 -p operationcount=30000000 -p threadcount=20 -s > ./exp/$4/$2/result_$3/$2-$1-run-workload-b.txt
echo "$2_workloadc_run" > current.txt
./bin/ycsb run $2 -P ./workloads/workloadc -p recordcount=50000000 -p operationcount=30000000 -p threadcount=20 -s > ./exp/$4/$2/result_$3/$2-$1-run-workload-c.txt
echo "$2_workloadf_run" > current.txt
./bin/ycsb run $2 -P ./workloads/workloadf -p recordcount=50000000 -p operationcount=30000000 -p threadcount=20 -s > ./exp/$4/$2/result_$3/$2-$1-run-workload-f.txt
echo "$2_workloadd_run" > current.txt
./bin/ycsb run $2 -P ./workloads/workloadd -p recordcount=50000000 -p operationcount=30000000 -p threadcount=20 -s > ./exp/$4/$2/result_$3/$2-$1-run-workload-d.txt

mongo ycsb --eval "db.dropDatabase()"
sleep 5
systemctl restart mongod
sleep 5

echo "$2_workloade_load" > current.txt
./bin/ycsb load $2 -P ./workloads/workloade -p recordcount=50000000 -p operationcount=30000000 -p threadcount=20 -s > ./exp/$4/$2/result_$3/$2-$1-load-workload-e.txt
echo "$2_workloade_run" > current.txt
./bin/ycsb run $2 -P ./workloads/workloade -p recordcount=50000000 -p operationcount=3000000 -p threadcount=20 -s > ./exp/$4/$2/result_$3/$2-$1-run-workload-e.txt

mongo ycsb --eval "db.dropDatabase()"
sleep 5
systemctl restart mongod
sleep 5

echo "Finish!"

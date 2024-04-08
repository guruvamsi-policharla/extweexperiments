set -ex
trap "exit" INT TERM
trap "kill 0" EXIT

sudp tc qdisc add dev ens4 root netem delay 100ms 10ms

n=$(<n)
names=$(for i in $(seq 0 $((n-1))); do echo "node-$i "; done)

for name in $names
do
  gcloud compute ssh $name --zone=us-central1-a --internal-ip --command="sudo tc qdisc add dev ens4 root netem delay 100ms 10ms" &
done
wait

trap - INT TERM EXIT
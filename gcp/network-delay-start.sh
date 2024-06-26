set -ex
trap "exit" INT TERM
trap "kill 0" EXIT

DELAY_TIME=200ms
JITTER_TIME=10ms
RATE=10mbit

sudo tc qdisc add dev ens4 root netem delay $DELAY_TIME $JITTER_TIME rate $RATE

n=$(<n)
names=$(for i in $(seq 0 $((n-1))); do echo "node-$i "; done)

for name in $names
do
  gcloud compute ssh $name --zone=us-central1-a --internal-ip --command="sudo tc qdisc add dev ens4 root netem delay $DELAY_TIME $JITTER_TIME rate $RATE" &
done
wait

trap - INT TERM EXIT
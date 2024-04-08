set -ex
trap "exit" INT TERM
trap "kill 0" EXIT

sudo tc qdisc del dev ens4 root netem

n=$(<n)
names=$(for i in $(seq 0 $((n-1))); do echo "node-$i "; done)

for name in $names
do
  gcloud compute ssh $name --zone=us-central1-a --internal-ip --command="sudo tc qdisc del dev ens4 root netem" &
done
wait

trap - INT TERM EXIT
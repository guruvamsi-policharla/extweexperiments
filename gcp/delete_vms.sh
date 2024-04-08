set -ex
trap "exit" INT TERM
trap "kill 0" EXIT

# Create VMs
n=$(< n) # Total parties including strong-machine

names=$(for i in $(seq 0 $((n-1))); do echo "node-$i "; done)

# Delete VMs
gcloud compute instances delete $names --zone=us-central1-a -q

trap - INT TERM EXIT
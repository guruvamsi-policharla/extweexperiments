set -ex
trap "exit" INT TERM
trap "kill 0" EXIT

n=$(< n)

PROJ=~/extweexperiments

# A place to store the network data
VM_FILE=$PROJ/gcp/vms
DATA_FILE=$PROJ/gcp/host_sockets

# clean up previously used files
rm -f $VM_FILE
rm -f $DATA_FILE
touch $VM_FILE
touch $DATA_FILE

names=$(for i in $(seq 0 $((n-1))); do echo "node-$i "; done)

gcloud compute instances start $names \
    --zone us-central1-a\
    --project "batch-threshold" \

sleep 30

for name in $names
do
  echo $name >> $VM_FILE
done

# Get the list of instances with their IP addresses
INSTANCE_INFO=$(gcloud compute instances list --project batch-threshold --format="csv[no-heading](name, networkInterfaces[0].networkIP, networkInterfaces[0].accessConfigs[0].natIP)")

declare -A addresses

# Retrieve the private IPs of the VMs
for name in $names
do
  privip=$(echo "$INSTANCE_INFO" | grep "^$name," | cut -d ',' -f 2)
  echo "${privip}:50500" >> $DATA_FILE
  addresses[$name]="${privip}:50500"
done

echo "Sending host_sockets file to nodes"

# SCP the host file to each of the nodes
for name in $names
do
  gcloud compute scp $DATA_FILE $name:~/extweexperiments/gcp/ --zone=us-central1-a --internal-ip &
done
wait
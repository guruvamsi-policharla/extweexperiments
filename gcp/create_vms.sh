set -ex
trap "exit" INT TERM
trap "kill 0" EXIT

PROJ=~/extweexperiments

# Create VMs
n=$(< n)

names=$(for i in $(seq 1 $(($n))); do echo "node-$i "; done)

gcloud compute instances create $names \
    --project=batch-threshold \
    --zone=us-central1-a \
    --machine-type=e2-small \
    --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default,no-address \
    --no-restart-on-failure \
    --maintenance-policy=TERMINATE \
    --provisioning-model=SPOT \
    --instance-termination-action=STOP \
    --service-account=265740592771-compute@developer.gserviceaccount.com \
    --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
    --create-disk=auto-delete=yes,boot=yes,device-name=node,image=projects/debian-cloud/global/images/debian-12-bookworm-v20240312,mode=rw,size=10,type=projects/batch-threshold/zones/us-central1-a/diskTypes/pd-balanced \
    --no-shielded-secure-boot \
    --shielded-vtpm \
    --shielded-integrity-monitoring \
    --labels=goog-ec-src=vm_add-gcloud \
    --reservation-affinity=any || true

sleep 30

# SSH and execute the node.sh script
for name in $names
do
  gcloud compute ssh $name --zone=us-central1-a --internal-ip -- bash -s < ../node.sh &>/dev/null &
done
wait

trap - INT TERM EXIT
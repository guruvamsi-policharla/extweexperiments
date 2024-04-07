names=$(for i in $(seq 1 $(($n))); do echo "node-$i "; done)

# Stop VMs
for name in $names; do
  gcloud compute instances stop $name --zone us-central1-a --project "batch-threshold" &
done
wait
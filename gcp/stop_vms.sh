n=$(< n)

names=$(for i in $(seq 0 $(($n-1))); do echo "node-$i"; done)

echo $names

# Stop VMs
for name in $names 
do
  gcloud compute instances stop $name --zone us-central1-a --project "batch-threshold" &
done
wait
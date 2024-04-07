names=$(for i in $(seq 1 $(($n))); do echo "node-$i "; done)
gcloud compute instances stop $names \
    --zone us-central1-a\
    --project "batch-threshold" \
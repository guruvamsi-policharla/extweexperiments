# check whether host_sockets file exists
if [ -f /home/vamsi/extweexperiments/gcp/host_sockets ]; then
    echo "host_sockets file exists"
else
    echo "host_sockets file does not exist"
    exit 2
fi

# Read the list of ips into an array form host_sockets
mapfile -t ip_list < /home/vamsi/extweexperiments/gcp/host_sockets

# Check that size of ip_list is equal to n
n=$(<n)
if [ ${#ip_list[@]} -ne $n ]; then
    echo "The number of IPs in host_sockets is not equal to n"
    exit 2
fi

# Have the VMs start listening
for i in $(seq 1 $n)
do
  name="node-$i"
  echo $name
  gcloud compute ssh $name --zone=us-central1-a --internal-ip --command="cd /home/vamsi/extweexperiments/network; /home/vamsi/dpss-env/bin/python3 node.py -a ${ip_list[$((i-1))]} -i $((i-1))" & #fix the indexing here
done
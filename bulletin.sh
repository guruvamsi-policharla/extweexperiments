cd /local/repository

echo "Installing Required Packages..."

echo "Installing pip"
sudo apt update
sudo apt --assume-yes install python3-pip

echo "Installing gmp"
sudo apt-get --assume-yes install libgmp-dev
sudo apt-get --assume-yes install swig

echo "Installing Python packages"
sudo python3 -m pip install Pyro4 numpy

echo "Building"
sudo make

echo "Starting Nameserver"
#cd network
#python3 nameserver.py

echo "GRPC"
cd grpc #/local/repository/grpc
pip3 install --upgrade pip
python3 -m pip install grpcio
pip3 install grpcio-tools
python3 -m grpc_tools.protoc --proto_path=. --python_out=. --grpc_python_out=. services.proto

python3 bulletin.py -a "bulletin:50050" -k "node0:50050"


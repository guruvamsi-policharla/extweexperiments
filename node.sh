echo "Installing Required Packages"

echo "Installing gmp"
sudo apt-get --assume-yes install libgmp-dev
sudo apt-get --assume-yes install swig

echo "Installing pip"
sudo apt update
sudo apt --assume-yes install python3-pip
sudo apt --assume-yes install python3-venv

python3 -m venv dpss-env
source dpss-env/bin/activate

echo "Installing Python packages"
pip3 install numpy grpcio grpcio-tools pytz

sudo apt install git
git clone https://github.com/guruvamsi-policharla/extweexperiments.git
cd extweexperiments
sudo make

# echo "Installing pip"
# sudo apt update
# sudo apt --assume-yes install python3-pip

# echo "Installing gmp"
# sudo apt-get --assume-yes install libgmp-dev
# sudo apt-get --assume-yes install swig

# echo "Installing Python packages"
# sudo python3 -m pip install numpy

# echo "GRPC"
# sudo -H pip3 install --upgrade pip
# sudo python3 -m pip install grpcio
# sudo -H pip3 install grpcio-tools

# echo "Additional"
# sudo pip3 install pytz

# echo "Building"
# sudo make

# echo "Starting node${1}:${2}"
# cd network
# python3 node.py -a "node${1}:${2}" -i $1



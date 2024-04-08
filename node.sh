echo "Installing Required Packages"

echo "Installing gmp"
sudo apt-get --assume-yes install libgmp-dev
sudo apt-get --assume-yes install swig

echo "Installing iproute2"
sudo apt-get --assume-yes install iproute2

echo "Installing pip"
sudo apt update
sudo apt --assume-yes install python3-pip
sudo apt --assume-yes install python3-venv

python3 -m venv dpss-env
source dpss-env/bin/activate

echo "Installing Python packages"
pip3 install numpy grpcio grpcio-tools pytz

sudo apt --assume-yes install git
git clone https://github.com/guruvamsi-policharla/extweexperiments.git
cd extweexperiments
sudo make


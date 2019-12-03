# Install latest golang
sudo add-apt-repository ppa:longsleep/golang-backports -y
sudo apt-get update
sudo apt-get install golang-go -y
sudo apt-get install git-review -y

# Use python3 by default
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 10

# ssh-keygen
ssh-keygen

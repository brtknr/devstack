# Install latest golang
sudo add-apt-repository ppa:longsleep/golang-backports -y
sudo apt-get update
sudo apt-get install golang-go -y
sudo apt-get install git-review -y

# Install sonobuoy
go get -u -v github.com/heptio/sonobuoy
echo "PATH=$PATH:~/go/bin" >> ~/.bash_profile

# ssh-keygen
ssh-keygen

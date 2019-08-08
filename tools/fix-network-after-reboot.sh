sudo ip addr a 172.24.4.1/24 dev br-ex
sudo ip link set dev br-ex up
sudo sysctl net.ipv4.ip_forward=1
sudo iptables -t nat -A POSTROUTING -o em1 -j MASQUERADE

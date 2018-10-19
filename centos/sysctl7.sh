#!/bin/sh
# centos 7 内核优化

if [ ! -f '/root/sysctl.conf' ]; then
	cp /etc/sysctl.conf /root/sysctl.conf
	cat >> /etc/sysctl.conf << EOF
# Minimizing the amount of swapping
vm.swappiness = 20
vm.dirty_ratio = 80
vm.dirty_background_ratio = 5

# Increases the size of file handles and inode cache & restricts core dumps
fs.file-max = 2097152
fs.suid_dumpable = 0

# Change the amount of incoming connections and incoming connections backlog
net.core.somaxconn = 65535
net.core.netdev_max_backlog = 262144

# Increase the maximum amount of memory buffers
net.core.optmem_max = 25165824

# Increase the default and maximum send/receive buffers
net.core.rmem_default = 31457280
net.core.rmem_max = 67108864
net.core.wmem_default = 31457280
net.core.wmem_max = 67108864

# Enable TCP SYN cookie protection
net.ipv4.tcp_syncookies = 1

# Enable IP spoofing protection
net.ipv4.conf.all.rp_filter = 1

# Enable ignoring to ICMP requests and broadcasts request
net.ipv4.icmp_echo_ignore_all = 1
net.ipv4.icmp_echo_ignore_broadcasts = 1

# Enable logging of spoofed packets, source routed packets and redirect packets
net.ipv4.conf.all.log_martians = 1

# Disable IP source routing
net.ipv4.conf.all.accept_source_route = 0

# Disable ICMP redirect acceptance
net.ipv4.conf.all.accept_redirects = 0

EOF

sysctl -p

fi

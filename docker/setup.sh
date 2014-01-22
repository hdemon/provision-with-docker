#!/bin/sh


# fill your public key
PUBLIC_KEY='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC8lFkwlgkArGlunI/YZ/DqhwUEkSDOzC3/YRJU3YQBNhpg9YiPyhm27cjdIqTxUpgLzxpEd9/NiYbg8VTKfHY9sIc8ssANlxyllXEkk5hlk3yCFkF2Nl0U1d4pEnXfUVVBztA1C1/rMoUiIFqNPRb4LMuYd8+V92lJs2MN2Rubi8igOngfPOW535gmHcYQj6WLMM8sNrHsR6/Ys+ZhsKoovgSRX4T78kamz4Ip556AdUm6u4Gx0xjvJt28ZbtvBWODsBXPO06HOPjPZ2AkVsfCQzFlqaGov/NoZAvz7x1MA4JF/jFHB92/euqz943msQNNkEONREmiixc9qTCBwEuL'
# change ssh port
SSH_PORT=22


sudo apt-get --yes update
sudo apt-get --yes upgrade

sudo bash -c "cat > /etc/ssh/sshd_config" <<EOT
  Port $SSH_PORT
  Protocol 2
  HostKey /etc/ssh/ssh_host_rsa_key
  HostKey /etc/ssh/ssh_host_dsa_key
  HostKey /etc/ssh/ssh_host_ecdsa_key
  UsePrivilegeSeparation yes
  KeyRegenerationInterval 3600
  ServerKeyBits 768
  SyslogFacility AUTH
  LogLevel INFO
  LoginGraceTime 120
  PermitRootLogin no
  StrictModes yes
  RSAAuthentication yes
  PubkeyAuthentication yes
  IgnoreRhosts yes
  RhostsRSAAuthentication no
  HostbasedAuthentication no
  PermitEmptyPasswords no
  ChallengeResponseAuthentication no
  PasswordAuthentication no
  X11Forwarding yes
  X11DisplayOffset 10
  PrintMotd no
  PrintLastLog yes
  TCPKeepAlive yes
  AcceptEnv LANG LC_*
  Subsystem sftp /usr/lib/openssh/sftp-server
  UsePAM yes
EOT

sudo sh -c "echo 'docker ALL=(ALL) ALL' >> /etc/sudoers"

sudo adduser --gecos "" docker
sudo mkdir ~docker/.ssh
sudo touch ~docker/.ssh/authorized_keys
sudo sh -c "echo $PUBLIC_KEY >> ~docker/.ssh/authorized_keys"
sudo chown -R docker ~docker/.ssh
sudo chmod 700 ~docker/.ssh
sudo chmod 600 ~docker/.ssh/authorized_keys
sudo service ssh restart

sudo apt-get install  linux-image-generic-lts-raring \
                      linux-headers-generic-lts-raring


sudo sh -c "wget -qO- https://get.docker.io/gpg | apt-key add -"
sudo sh -c "echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"

sudo apt-get update
sudo apt-get install lxc-docker

sudo shutdown -r now
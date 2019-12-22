#!/usr/bin/env sh

set -m

# Create host keys if they haven't been created already
if [ ! -f /etc/ssh/ssh_host_rsa_key ]; then
    ssh-keygen -A
fi

# Copy the SSH config if it hasn't already been setup
if [ ! -f /etc/ssh/sshd_config ]; then
    cp /sshd_config /etc/ssh/sshd_config
fi

/usr/sbin/sshd -De &

/usr/sbin/crond -fd8 &

/usr/sbin/httpd -DFOREGROUND

fg %1
fg %2

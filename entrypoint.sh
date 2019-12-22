#!/usr/bin/env sh

set -m

/usr/sbin/sshd -De &

/usr/sbin/crond -fd8 &

/usr/sbin/httpd -DFOREGROUND

fg %1
fg %2

#!/bin/bash
groupadd -g ${gid:-1001} ${user:-theia}
useradd -u ${uid:-1001} -g ${gid:-1001} ${user:-theia}
echo "${user:-theia} ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers
echo "$@"
chown ${user:-theia}: /home/theia -R
sudo -E -u ${user:-theia} "PATH=$PATH" "$@"

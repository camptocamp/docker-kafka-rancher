#!/bin/sh -ex

for format in rsa dsa ecdsa ed25519; do
  test -f "/etc/ssh/ssh_host_${format}_key" && continue
  ssh-keygen -f "/etc/ssh/ssh_host_${format}_key" -N '' -t $format
  ssh-keygen -l -f "/etc/ssh/ssh_host_${format}_key.pub"
done

test -n "$USERLIST" || echo 'Not adding any users. You can pass a list of users with: --env USERLIST="..."'

echo > /home/kafka/.ssh/authorized_keys

for user in $USERLIST; do
  curl --max-time 15 -s "https://github.com/${user}.keys" >> "/home/${KAFKA_USER}/.ssh/authorized_keys"
done

exec /usr/sbin/sshd -D

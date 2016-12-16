#!/bin/sh

# Fix /tmp/kafka-logs permissions
chown -R kafka /tmp/kafka-logs

runsvdir -P /etc/service/

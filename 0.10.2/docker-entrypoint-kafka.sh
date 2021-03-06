#!/bin/sh

# Fix /tmp/kafka-logs permissions
chown -R kafka /tmp/kafka-logs

sed -i -e 's@.*listeners=.*$@listeners=PLAINTEXT://'"$(hostname -f)"':9092@' /kafka/config/server.properties

echo
echo "== /kafka/config/server.properties =="
cat /kafka/config/server.properties

exec gosu kafka /kafka/bin/kafka-server-start.sh /kafka/config/server.properties

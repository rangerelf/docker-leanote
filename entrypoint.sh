#!/bin/bash
[[ -x "$1" ]] && exec "$@"

MONGODB_ADDR=${MONGODB_ADDR:-127.0.0.1}

# Start up mongodb.
mkdir -p /data/mongodb
mongod --bind_ip $MONGODB_ADDR --dbpath /data/mongodb &
sleep 2s

if [[ ! -f /data/app.conf ]]; then
  echo "Initializing leanote setup" >&2
  mongorestore -h localhost -d leanote \
    --dir /opt/leanote/mongodb_backup/leanote_install_data/
  RNDSTR=$(dd if=/dev/urandom bs=1 count=32 2>/dev/null | base64 -w0 | cut -d= -f1)
  cat >&2 <<EOT
=============================================================
This is the new randomized security key:
>>>
>>> $RNDSTR
>>>
=============================================================
EOT
  sed "s|^app\\.secret=.*$|app.secret=$RNDSTR|g" \
    /opt/leanote/conf/app.conf.orig > /data/app.conf
fi
/opt/leanote/bin/run.sh
pkill -TERM mongod
wait

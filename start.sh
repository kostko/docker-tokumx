#!/bin/bash

DATADIR="/data/db"

# Disable huge pages (requires privileged container)
echo never > /sys/kernel/mm/transparent_hugepage/enabled

# Create the data directory if one does not exist
if [ ! -d $DATADIR ]; then
  mkdir -p $DATADIR
  chown tokumx:tokumx $DATADIR
fi

# Start TokuMX server
trap "echo \"Sending SIGTERM to postgres\"; killall -s SIGTERM postgres" SIGTERM
sudo -u tokumx /usr/bin/mongod &
wait $!


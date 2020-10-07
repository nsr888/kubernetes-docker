#!/bin/sh
rc-update add influxdb default
rc-update add telegraf default
#sed -i -E "s|  \# (skip_database_creation = )false|\1true|g" /etc/telegraf.conf
echo "[[inputs.http_listener_v2]]
service_address = \":8080\"
path = \"/telegraf\"
basic_username = \"ft\"
basic_password = \"ft\"
data_format = \"influx\"
" >> /etc/telegraf.conf
#curl -i -XPOST http://localhost:8086/query --data-urlencode "q=CREATE DATABASE telegraf"
telegraf --config /etc/telegraf.conf &
influxd &

# ================== Run multiple services in a container ===================
# https://docs.docker.com/config/containers/multi-service_container/
# Naive check runs checks once a minute to see if either of the processes exited.
# This illustrates part of the heavy lifting you need to do if you want to run
# more than one service in a container. The container exits with an error
# if it detects that either of the processes has exited.
# Otherwise it loops forever, waking up every 60 seconds

while sleep 5; do
  ps aux |grep influxd |grep -q -v grep
  PROCESS_1_STATUS=$?
  ps aux |grep telegraf |grep -q -v grep
  PROCESS_2_STATUS=$?
  # If the greps above find anything, they exit with 0 status
  # If they are not both 0, then something is wrong
  if [ $PROCESS_1_STATUS -ne 0 -o $PROCESS_2_STATUS -ne 0 ]; then
    echo "One of the processes has already exited."
    exit 1
  fi
done

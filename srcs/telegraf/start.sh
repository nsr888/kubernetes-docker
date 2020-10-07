#!/bin/sh
rc-update add telegraf default
sed -i "s|\$HOSTNAME|$HOSTNAME|g" /etc/telegraf/telegraf.conf
sed -i "s|\$MONITOR_HTTP_HOST|http://$INFLUXDB_SERVICE_HOST:8080|g" /etc/telegraf/telegraf.conf
#sed -i "s|\$MONITOR_HOST|http://$MONITOR_HOST:8086|g" /etc/telegraf/telegraf.conf
sed -i "s|\$MONITOR_DATABASE|telegraf|g" /etc/telegraf/telegraf.conf
sed -i "s|\$MONITOR_USERNAME|telegraf|g" /etc/telegraf/telegraf.conf
sed -i "s|\$MONITOR_PASSWORD|telegraf|g" /etc/telegraf/telegraf.conf
curl -s $KUBERNETES_SERVICE_HOST/api/v1/namespaces/$MY_POD_NAMESPACE/pods/$HOSTNAME --header "Authorization: Bearer $TOKEN" --insecure | jq -r '.status.hostIP'
sed -i "s|\$KUBERNETES_SERVICE_HOST|$NODE_IP|g" /etc/telegraf/telegraf.conf
sed -i "s|\$KUBERNETES_SERVICE_PORT_HTTPS|10255|g" /etc/telegraf/telegraf.conf
telegraf --config /etc/telegraf/telegraf.conf

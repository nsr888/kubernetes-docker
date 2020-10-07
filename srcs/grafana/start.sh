#!/bin/sh
cd /usr/share/grafana
rc-update add grafana default
grafana-cli admin reset-admin-password 123456
grafana-server

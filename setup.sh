#!/bin/sh
minikube start --driver=hyperkit
minikube addons enable metallb
kubectl apply -f ./srcs/metallb-config.yaml

eval $(minikube docker-env)
docker build -t nginx_alpine ./srcs/nginx/
docker build -t ftps_alpine ./srcs/ftps/
docker build -t mysql_alpine ./srcs/mysql/
docker build -t wordpress_alpine ./srcs/wordpress/
docker build -t phpmyadmin_alpine ./srcs/phpmyadmin/
docker build -t influxdb_alpine ./srcs/influxdb/
docker build -t grafana_alpine ./srcs/grafana/
docker build -t telegraf_alpine ./srcs/telegraf/

kubectl apply -f ./srcs/nginx/nginx.yaml
kubectl apply -f ./srcs/ftps/ftps.yaml
kubectl apply -f ./srcs/mysql/mysql.yaml
kubectl apply -f ./srcs/wordpress/wordpress.yaml
kubectl apply -f ./srcs/phpmyadmin/phpmyadmin.yaml
kubectl apply -f ./srcs/influxdb/influxdb.yaml
kubectl apply -f ./srcs/grafana/grafana.yaml
kubectl apply -f ./srcs/telegraf/telegraf.yaml

minikube dashboard

#!/bin/sh
echo "Adding routes to routers..."
docker-compose exec r01 gobgp global rib add 192.168.255.0/24 -a ipv4
docker-compose exec r01 gobgp global rib add 10.0.255.0/24 -a ipv4

docker-compose exec r02 gobgp global rib add 192.168.254.0/24 -a ipv4
docker-compose exec r02 gobgp global rib add 10.0.255.0/24 -a ipv4

docker-compose exec r03 gobgp global rib add 192.168.253.0/24 -a ipv4
docker-compose exec r03 gobgp global rib add 10.0.255.0/24 -a ipv4

docker-compose exec location-r01 gobgp global rib add 192.168.250.0/24 -a ipv4
docker-compose exec location-r01 gobgp global rib add 10.0.250.0/24 -a ipv4

docker-compose exec location-r02 gobgp global rib add 192.168.249.0/24 -a ipv4
docker-compose exec location-r02 gobgp global rib add 10.0.250.0/24 -a ipv4

docker-compose exec location-r03 gobgp global rib add 192.168.248.0/24 -a ipv4
docker-compose exec location-r03 gobgp global rib add 10.0.250.0/24 -a ipv4

echo "Current global RIB on r01:"
docker-compose exec r01 gobgp global rib
echo "Current global RIB on location-r01:"
docker-compose exec location-r01 gobgp global rib

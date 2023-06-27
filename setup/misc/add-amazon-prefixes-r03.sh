#!/usr/bin/env bash

for prefix in $(cat amazon-ip4-prefixes.txt); do
  docker-compose exec r03 gobgp global rib add ${prefix} -a ipv4
done


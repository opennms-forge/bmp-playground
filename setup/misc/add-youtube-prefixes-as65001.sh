#!/usr/bin/env bash

for prefix in $(cat youtube-ip4-prefixes.txt); do
  docker-compose exec r02 gobgp global rib add ${prefix} -a ipv4
done


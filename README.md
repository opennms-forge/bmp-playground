# Playground to monitor BGP with BMP

This repository has a test environment to implement BGP monitoring using BMP protocol.
This environment provides the following network topology.

![](bgp-playground.png)

There are two custom GraphML topologies provided:

Layer 3 Network topology

![](layer3-topology.png)

BGP Topology

![](bgp-topology.png)

## Usage

Clone the repository and startup the application stack

```
cd bmp-playground
docker-compose up -d
```

Provision nodes and the GraphML network topologies

```
cd setup
./provision.sh
```

## Command examples

Administratively shutdown a peering session between r01 (AS64512) and r02 (AS65001)
```
docker-compose exec r01 gobgp neighbor 10.0.255.6 disable
```

Show BGP neighborhood status
```
docker-compose exec r01 gobgp neighbor
```

Add some routes
```
docker-compose exec r02 gobgp global rib add 10.36.0.0/16 -a ipv4
docker-compose exec location-r02 gobgp global rib add 10.37.0.0/16 -a ipv4
```



Debug and trigger statistics
```
admin@opennms()> log:set DEBUG org.opennms.netmgt.telemetry.protocols.bmp
admin@opennms()> bmp-stats-update
```

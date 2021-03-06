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

Download Minion and Horizon container images from the [artifacts](https://circleci.com/gh/OpenNMS/opennms/tree/features%2Fbmp) from features/bmp branch and load them with `docker load -i`.

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

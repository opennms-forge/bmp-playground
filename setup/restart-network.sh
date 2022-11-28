#!/bin/sh
echo "Restarting all routers..."
docker-compose restart r01 r02 r03 location-r01 location-r02 location-r03

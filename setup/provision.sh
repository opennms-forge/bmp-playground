#!/usr/bin/env bash

OPENNMS_HOST="localhost"
OPENNMS_USER="admin"
OPENNMS_PASS="admin"
OPENNMS_PORT="8980"

echo -n "Ensure the ReST API is running before setup        "
until curl -L --output /dev/null --silent --head --fail http://${OPENNMS_HOST}:8980; do
    printf '.'
    sleep 2
done
echo "    DONE"

#
# Setup BGP network data with foreign sources, requisitions and a topology
#
echo -n "Create Foreign Source: OpenNMS Stack               ... "
curl -s -u ${OPENNMS_USER}:${OPENNMS_PASS} \
     -X POST \
     -H "Content-Type: application/xml" \
     -H "Accept: application/xml" \
     -d @foreign-source-opennms-stack.xml \
     http://${OPENNMS_HOST}:${OPENNMS_PORT}/opennms/rest/foreignSources
echo "DONE"

echo -n "Create Foreign Source: BGP Routers                 ... "
curl -s -u ${OPENNMS_USER}:${OPENNMS_PASS} \
     -X POST \
     -H "Content-Type: application/xml" \
     -H "Accept: application/xml" \
     -d @foreign-source-bgp-routers.xml \
     http://${OPENNMS_HOST}:${OPENNMS_PORT}/opennms/rest/foreignSources
echo "DONE"

echo -n "Create Requisition: OpenNMS Stack                  ... "
curl -s -u ${OPENNMS_USER}:${OPENNMS_PASS} \
     -X POST \
     -H "Content-Type: application/xml" \
     -H "Accept: application/xml" \
     -d @opennms-stack.xml \
     http://${OPENNMS_HOST}:${OPENNMS_PORT}/opennms/rest/requisitions
echo "DONE"

echo -n "Create Requisition: BGP Routers                    ... "
curl -s -u ${OPENNMS_USER}:${OPENNMS_PASS} \
     -X POST \
     -H "Content-Type: application/xml" \
     -H "Accept: application/xml" \
     -d @bgp-routers.xml \
     http://${OPENNMS_HOST}:${OPENNMS_PORT}/opennms/rest/requisitions
echo "DONE"

echo -n "Import requisition: OpenNMS Stack                  ... "
curl -s -u ${OPENNMS_USER}:${OPENNMS_PASS} \
     -X PUT \
     http://${OPENNMS_HOST}:${OPENNMS_PORT}/opennms/rest/requisitions/opennms-stack/import
echo "DONE"

echo -n "Import requisition: BGP Routers                    ... "
curl -s -u ${OPENNMS_USER}:${OPENNMS_PASS} \
     -X PUT \
     http://${OPENNMS_HOST}:${OPENNMS_PORT}/opennms/rest/requisitions/bgp-routers/import
echo "DONE"

echo -n "Create GraphML: Layer 3 network                    ... "
curl -s -u ${OPENNMS_USER}:${OPENNMS_PASS} \
    -X DELETE \
    http://${OPENNMS_HOST}:${OPENNMS_PORT}/opennms/rest/graphml/network-layer3
sleep 2
curl -s -u ${OPENNMS_USER}:${OPENNMS_PASS} \
    -X POST \
    -H "Content-Type: application/xml" \
    -d @network-layer3.xml \
    http://${OPENNMS_HOST}:${OPENNMS_PORT}/opennms/rest/graphml/network-layer3
echo "DONE"


echo -n "Create GraphML: BGP network                        ... "
curl -s -u ${OPENNMS_USER}:${OPENNMS_PASS} \
    -X DELETE \
    http://${OPENNMS_HOST}:${OPENNMS_PORT}/opennms/rest/graphml/network-bgp
sleep 2
curl -s -u ${OPENNMS_USER}:${OPENNMS_PASS} \
    -X POST \
    -H "Content-Type: application/xml" \
    -d @network-bgp.xml \
    http://${OPENNMS_HOST}:${OPENNMS_PORT}/opennms/rest/graphml/network-bgp
echo "DONE"


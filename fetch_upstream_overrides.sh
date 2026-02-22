#!/bin/bash

export OPENSTACK_RELEASE=2025.2
#TODO: There are other neat features we could look at
# https://opendev.org/openstack/openstack-helm/src/branch/master/values_overrides

# Features enabled for the deployment. This is used to look up values overrides.
export FEATURES="${OPENSTACK_RELEASE} ubuntu_noble netpol"
# Directory where values overrides are looked up or downloaded to.
export OVERRIDES_DIR=$(pwd)/overrides_upstream


export OVERRIDES_URL=https://opendev.org/openstack/openstack-helm/raw/branch/master/values_overrides

# Fetch `values.yaml` override for some basic services
for chart in rabbitmq mariadb memcached openvswitch libvirt; do
    helm osh get-values-overrides -d -u ${OVERRIDES_URL} -p ${OVERRIDES_DIR} -c ${chart} ${FEATURES}
done

for chart in keystone heat glance cinder placement nova neutron horizon; do
    helm osh get-values-overrides -d -u ${OVERRIDES_URL} -p ${OVERRIDES_DIR} -c ${chart} ${FEATURES}
done

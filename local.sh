#!/usr/bin/env bash

# Sample ``local.sh`` for user-configurable tasks to run automatically
# at the successful conclusion of ``stack.sh``.

# NOTE: Copy this file to the root DevStack directory for it to work properly.

# This is a collection of some of the things we have found to be useful to run
# after ``stack.sh`` to tweak the OpenStack configuration that DevStack produces.
# These should be considered as samples and are unsupported DevStack code.


# Keep track of the DevStack directory
TOP_DIR=$(cd $(dirname "$0") && pwd)

# Import common functions
source $TOP_DIR/functions

# Use openrc + stackrc + localrc for settings
source $TOP_DIR/stackrc

# Destination path for installation ``DEST``
DEST=${DEST:-/opt/stack}

if is_service_enabled nova; then

    # Import ssh keys
    # ---------------

    # Import keys from the current user into the default OpenStack user (usually
    # ``demo``)

    # Get OpenStack user auth
    export OS_CLOUD=devstack

    # Add first keypair found in localhost:$HOME/.ssh
    keyfile=$HOME/.ssh/id_rsa
    if [[ ! -r $keyfile.pub ]]; then
        ssh-keygen -f $keyfile -t rsa -N ''
    fi
    openstack keypair create --public-key $keyfile.pub default

    # Update security default group
    # -----------------------------

    # Add tcp/22 and icmp to default security group
    default=$(openstack security group show default -f value -c id)
    openstack security group rule create $default --protocol tcp --dst-port 22
    openstack security group rule create $default --protocol icmp

    # Increase cores quota
    # ---------------------

    # Get OpenStack admin auth
    export OS_CLOUD=devstack-admin

    openstack quota set --cores 48 demo
fi

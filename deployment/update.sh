#!/bin/bash

set -x

# Updates a via server, only the server part, without application internals. Use deploy.sh for a full deployment.
#
# Usage: ./update.sh <name of instance>
# Example: ./update.sh production

# NOT needed: --ask-become-pass
ansible-playbook "${@:2}" -i site/inventory_$1.yml -e instanceName=$1 playbook_update.yml

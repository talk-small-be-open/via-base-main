#!/bin/bash

# Deploys an already running via server to the newest state.
#
# Usage: ./deploy.sh <name of instance>
# Example: ./deploy.sh production

while getopts "g" opt; do
		case ${opt} in
				g ) # process option h
						GEMSTONE_ONLY="-e gemstoneOnly=true"
						shift
						;;
				\? ) echo "Usage: cmd [-g = gemstone only]"
						 exit
						 ;;
		esac
done

# NOT needed: --ask-become-pass
ansible-playbook -i ./site/inventory_$1.yml -e instanceName=$1 $GEMSTONE_ONLY playbook_deploy.yml

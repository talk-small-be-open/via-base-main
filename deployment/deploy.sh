#!/bin/bash

# Deploys an already running via server to the newest state.
#
# Usage: ./deploy.sh <name of instance>
# Example: ./deploy.sh production

while getopts "gs" opt; do
		case ${opt} in
				g ) # process option h
						GEMSTONE_ONLY="-e gemstoneOnly=true"
						;;
				s ) SKIP_BACKUP="-e skipBackup=true"
						;;
				\? ) echo "Usage: cmd [-g = gemstone only] [-s = skip backup]"
						 exit
						 ;;
		esac
done

shift $((OPTIND-1))

# NOT needed: --ask-become-pass
ansible-playbook -i ./site/inventory_$1.yml -e instanceName=$1 $GEMSTONE_ONLY $SKIP_BACKUP playbook_deploy.yml

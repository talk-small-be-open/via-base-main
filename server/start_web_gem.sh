#!/bin/bash

STONE=$1
PORT=$2

cd $(dirname "${BASH_SOURCE[0]}")

# $GS_HOME/bin/todeIt $STONE /home/seaside/gemServer --restart=seaside$PORT

./executeSmalltalk.sh $STONE "(GemServer gemServerNamed: 'seaside$PORT') restartGems"

#
# "unregister"
# result := GemServer removeGemServerNamed: serverName
#
# "register"
# gemServer := (GemServer gemServerNamed: serverName) ifNil: [ ZnSeasideNewGemServer register: serverName ].
# gemServer ports: {(portString asNumber)}.
#
# result := (GemServer gemServerNamed: serverName) restartGems.
# result := (GemServer gemServerNamed: serverName) startGems.
# result := (GemServer gemServerNamed: serverName) stopGems.

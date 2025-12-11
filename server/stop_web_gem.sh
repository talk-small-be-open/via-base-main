#!/bin/bash

STONE=$1
PORT=$2

cd $(dirname "${BASH_SOURCE[0]}")

# $GS_HOME/bin/todeIt $STONE /home/seaside/gemServer --stop=seaside$PORT

./executeSmalltalk.sh $STONE "(GemServer gemServerNamed: 'seaside$PORT') stopGems"

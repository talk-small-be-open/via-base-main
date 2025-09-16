#!/bin/bash

# --proxied true

peerjs --port 9001 --key peerjs --path /peerjs --proxied true --expire_timeout 60000 --alive_timeout 1800000 >> ./peerjs.log

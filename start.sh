#!/bin/bash

# Bind the localhost ip address to server
IPADDR=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
hugo server --bind $IPADDR --baseURL=http://$IPADDR

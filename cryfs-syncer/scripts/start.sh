#!/bin/bash

sleep infinity
# Setting Variables if not already in environment
# CRYFS_PWD=$(bashio::config "CRYFS_PWD")   
# BASE_DIR=$(bashio::config "BASE_DIR") 


export CRYFS_FRONTEND=noninteractive
if [ -z "$CRYFS_PWD" ]; then
    echo "########## No Password Provided. Exiting...."
    sleep infinity
    exit 1
fi

echo "########## Bringing up Wireguard Tunnel ##########"
wg-quick up /config/cryfs/wg0.conf


echo "########## Setting up nfs Mount ##########"
if mount ${BASE_DIR} /cryfs/base; then
    echo "########## Mounted ${BASE_DIR} to /cryfs/base ##########" 
else
    echo "########## Couldn't mount ${BASE_DIR} ##########"
    sleep infinity
fi

if echo "${CRYFS_PWD}" | cryfs -c /config/cryfs/config/cryfs.cfg --logfile /config/cryfs/config/cryfs.log --blocksize ${CRYFS_BLOCKSIZE} ${CRYFS_EXTRA_PARAMETERS} /cryfs/base /tmp/mount; then
    echo "########## Started CryFS encryption ##########"   

    echo "########## Started lsyncd Sync ##########"
    lsyncd -nodaemon -log all -rsync /media/frigate/ /tmp/mount/
    # sleep infinity
else
    echo "########## Couldn't start CryFS encryption ##########"
    sleep infinity
fi

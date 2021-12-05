#!/bin/bash

export CRYFS_FRONTEND=noninteractive
if [ -z "$CRYFS_PWD" ]; then
    echo "########## No Password Provided. Exiting...."
    exit 1
fi

echo "Attempting to mount ${BASE_DIR} into ${MOUNT_DIR}"

if echo "${CRYFS_PWD}" | cryfs -c /cryfs/config/cryfs.cfg --logfile /cryfs/config/cryfs.log --blocksize ${CRYFS_BLOCKSIZE} ${CRYFS_EXTRA_PARAMETERS} /cryfs/base /tmp/mount; then
    echo "########## Started CryFS encryption ##########"
    lsyncd -nodaemon -log Normal -rsync /cryfs/sync/ /tmp/mount/
    echo "########## Started lsyncd encryption ##########"
    # sleep infinity
else
    echo "########## Couldn't start CryFS encryption ##########"
    exit
fi
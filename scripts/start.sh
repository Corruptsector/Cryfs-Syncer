#!/bin/bash


# #Define cleanup procedure
# cleanup() {
#     echo "Container stopped, performing cleanup..."
# }

# #Trap SIGTERM
# trap 'cleanup' SIGTERM


export CRYFS_FRONTEND=noninteractive
if [ -z "$CRYFS_PWD" ]; then
    echo "########## No Password Provided. Exiting...."
    exit 1
fi

if [ -z "$BASE_DIR" ]; then
 echo "########## No Base Directory Provided. Exiting...."
    exit 2
fi

if [ -z "$MOUNT_DIR" ]; then
 echo "########## No Mount Directory Provided. Exiting...."
    exit 2
fi

echo "Attempting to mount ${BASE_DIR} into ${MOUNT_DIR}"

if echo "${CRYFS_PWD}" | cryfs -c /cryfs/config/cryfs.cfg --logfile /cryfs/config/cryfs.log --blocksize ${CRYFS_BLOCKSIZE} ${CRYFS_EXTRA_PARAMETERS} ${BASE_DIR} ${MOUNT_DIR}; then
    echo "########## Started CryFS encryption ##########"
    lsyncd -rsync /cryfs/sync/ /cryfs/mount/
    echo "########## Started lsyncd encryption ##########"
    sleep infinity
else
    echo "########## Couldn't start CryFS encryption ##########"
    exit
fi
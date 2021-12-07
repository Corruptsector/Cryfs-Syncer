FROM ubuntu:latest
RUN apt-get update && apt-get install cryfs lsyncd wireguard net-tools iproute2 nfs-common iputils-ping -y
RUN mkdir -p /cryfs/base /tmp/mount 

ENV DATA_DIR="/cryfs/config"
ENV CRYFS=""
ENV CRYFS_PWD=""
ENV CRYFS_BLOCKSIZE=262144
ENV CRYFS_EXTRA_PARAMETERS=""
ENV MOUNT_DIR=""
ENV BASE_DIR=""

ADD /scripts/ /opt/scripts/

ENTRYPOINT ["/bin/bash", "/opt/scripts/start.sh"]
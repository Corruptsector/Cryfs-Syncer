FROM ghcr.io/home-assistant/amd64-base-debian

RUN apt-get update && apt-get install cryfs lsyncd wireguard net-tools iproute2 nfs-common iputils-ping -y
RUN mkdir -p /cryfs/base /tmp/mount 

ENV CRYFS_BLOCKSIZE=262144
ADD /scripts/ /opt/scripts/

ENTRYPOINT ["/bin/bash", "/opt/scripts/start.sh"]
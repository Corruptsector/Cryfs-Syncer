FROM ubuntu

RUN apt-get update && apt-get install cryfs lsyncd wireguard net-tools iproute2 nfs-common iputils-ping -y
RUN mkdir -p /cryfs/base /tmp/mount 

ENV CRYFS_BLOCKSIZE=262144
ADD /scripts/ /opt/scripts/

RUN chmod +x /opt/scripts/start.sh
ENTRYPOINT ["/opt/scripts/start.sh"]
FROM ubuntu:latest
RUN apt-get update && apt-get install cryfs -y
RUN mkdir /cryfs /cryfs/config /cryfs/mount /cryfs/base

ENV DATA_DIR="/cryfs/config"
ENV CRYFS=""
ENV CRYFS_PWD=""
ENV CRYFS_BLOCKSIZE=262144
ENV CRYFS_EXTRA_PARAMETERS=""
ENV MOUNT_DIR=""
ENV BASE_DIR=""

ADD /scripts/ /opt/scripts/

ENTRYPOINT ["/bin/bash", "/opt/scripts/start.sh"]
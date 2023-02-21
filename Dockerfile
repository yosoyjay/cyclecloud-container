FROM ubuntu:20.04 AS base

WORKDIR /cs-install

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
        wget \
        gnupg2

# Add Microsoft keys
RUN wget -qO - https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    echo "deb https://packages.microsoft.com/repos/cyclecloud bionic main" > /etc/apt/sources.list.d/cyclecloud.list

# Install Cycle Server
RUN apt-get update && apt-get install -y cyclecloud8

ENV CS_ROOT /opt/cycle_server
ENV BACKUPS_DIRECTORY /azurecyclecloud

ADD . /cs-install

CMD ["/cs-install/scripts/run.sh"]

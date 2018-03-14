FROM ubuntu:18.04
LABEL maintainer="David Bennett"

# Dependencies
RUN apt-get update \
    && apt-get install -y wget liblz4-tool \
    && cd /tmp \
    && wget https://repo.percona.com/apt/percona-release_0.1-5.bionic_all.deb \
    && dpkg -i percona-release_0.1-5.bionic_all.deb

COPY myentry.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

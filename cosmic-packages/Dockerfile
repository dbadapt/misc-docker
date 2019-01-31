FROM ubuntu:18.10
LABEL maintainer="David Bennett"

# Dependencies
RUN apt-get update \
    && apt-get install -y wget liblz4-tool lsb-release \
    && cd /tmp \
    && wget https://repo.percona.com/apt/percona-release_0.1-10.cosmic_all.deb \
    && (dpkg -i percona-release_0.1-10.cosmic_all.deb || true)

COPY myentry.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

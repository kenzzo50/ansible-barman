FROM debian:12-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8

RUN apt-get update -qq && \
    apt-get install -y -qq --no-install-recommends \
        curl \
        gnupg \
        lsb-release \
        ca-certificates \
        cron \
        openssh-server \
        openssh-client \
        rsync \
        procps \
        sudo \
        tini \
        gosu && \
    curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg && \
    echo "deb http://apt.postgresql.org/pub/repos/apt bookworm-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    apt-get update -qq && \
    apt-get install -y -qq --no-install-recommends \
        barman \
        barman-cli \
        postgresql-client-17 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/sshd /var/lib/barman/.ssh /var/log/barman /etc/barman.d && \
    chmod 700 /var/lib/barman/.ssh && \
    chown -R barman:barman /var/lib/barman /var/log/barman /etc/barman.d && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config && \
    ssh-keygen -A

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 22

ENTRYPOINT ["/usr/bin/tini", "--", "/docker-entrypoint.sh"]
CMD ["cron-loop"]

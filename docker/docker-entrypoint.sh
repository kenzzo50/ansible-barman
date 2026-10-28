#!/usr/bin/env bash
set -eo pipefail

chown -R barman:barman /var/lib/barman /var/log/barman /etc/barman.d 2>/dev/null || true
chmod 700 /var/lib/barman/.ssh 2>/dev/null || true
chmod 600 /var/lib/barman/.ssh/* 2>/dev/null || true
chmod 644 /var/lib/barman/.ssh/*.pub 2>/dev/null || true
chmod 600 /var/lib/barman/.pgpass 2>/dev/null || true

/usr/sbin/sshd

touch /var/log/barman/barman.log
chown barman:barman /var/log/barman/barman.log

service cron start

if [ "$1" = "cron-loop" ]; then
    echo "Barman backup daemon container initialized."
    exec tail -f /var/log/barman/barman.log
fi

exec "$@"

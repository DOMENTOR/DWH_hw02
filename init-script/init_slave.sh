#!/bin/bash
set -e

cp -f /etc/postgresql/postgresql.conf /var/lib/postgresql/data
echo "host    replication     replicator      0.0.0.0/0               trust" >> /var/lib/postgresql/data/pg_hba.conf

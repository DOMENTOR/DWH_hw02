#!/bin/bash
set -e

# # Проверяем наличие папки /var/lib/postgresql/data-slave
# if [ ! -d "/var/lib/postgresql/data-slave" ]; then
#     echo "Папка /var/lib/postgresql/data-slave не существует. Создаём..."
#     mkdir -p /var/lib/postgresql/data-slave
# fi

echo "wal_level = logical" >> /var/lib/postgresql/data/postgresql.conf

psql --username postgres --dbname postgres <<-EOSQL
    DROP ROLE IF EXISTS replicator;
    CREATE USER replicator WITH REPLICATION ENCRYPTED PASSWORD 'my_replicator_password';
    SELECT * FROM pg_create_physical_replication_slot('replication_slot_slave1');
EOSQL

# pg_basebackup -D /var/lib/postgresql/data-slave -S replication_slot_slave1 -X stream -P -U replicator -Fp -R
pg_basebackup -D /var/lib/postgresql/data -S replication_slot_slave1 -U replicator -P -Fp -Xs -R

# cp /etc/postgresql/init-script/slave-config/postgresql.auto.conf /var/lib/postgresql/data-slave/
# cp /etc/postgresql/init-script/config/pg_hba.conf /var/lib/postgresql/data-slave/
# ls -l /var/lib/postgresql/data-slave/

echo "primary_conninfo='host=postgres_master port=5432 user=postgres password=postgres'" >> /var/lib/postgresql/data/postgresql.auto.conf
echo "primary_slot_name = 'replication_slot_slave1'" >> /var/lib/postgresql/data/postgresql.auto.conf
echo "host    replication     replicator      0.0.0.0/0               trust" >> /var/lib/postgresql/data/pg_hba.conf


# #!/bin/bash
# set -e

# psql -v ON_ERROR_STOP=1 --username postgres --dbname postgres <<-EOSQL
#     DROP ROLE IF EXISTS replicator;
# 	CREATE USER replicator WITH REPLICATION ENCRYPTED PASSWORD 'my_replicator_password';
#     SELECT * FROM pg_create_physical_replication_slot('replication_slot_slave1');
# EOSQL


# pg_basebackup -D /var/lib/postgresql/data-slave -S replication_slot_slave1 -X stream -P -U replicator -Fp -R

# cp /etc/postgresql/init-script/slave-config/* /var/lib/postgresql/data-slave/
# cp /etc/postgresql/init-script/config/pg_hba.conf /var/lib/postgresql/data
# cp /etc/postgresql/init-script/slave-config/postgresql.auto.conf /var/lib/postgresql/data/

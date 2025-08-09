#!/bin/bash
set -e

# Use environment variables with defaults
REPLICATOR_USER=${REPLICATOR_USER:-replicator}
REPLICATOR_PASSWORD=${REPLICATOR_PASSWORD:-replicator123}
REPLICATION_SLOT=${REPLICATION_SLOT:-replica_slot}

echo "Creating replication user: $REPLICATOR_USER"
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
	-- Create replication user
	DO \$\$
	BEGIN
	   IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = '$REPLICATOR_USER') THEN
	      CREATE USER $REPLICATOR_USER WITH REPLICATION ENCRYPTED PASSWORD '$REPLICATOR_PASSWORD';
	   END IF;
	END
	\$\$;

	-- Create physical replication slot
	DO \$\$
	BEGIN
	   IF NOT EXISTS (SELECT FROM pg_replication_slots WHERE slot_name = '$REPLICATION_SLOT') THEN
	      PERFORM pg_create_physical_replication_slot('$REPLICATION_SLOT');
	   END IF;
	END
	\$\$;
EOSQL

echo "Replication setup completed"

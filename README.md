# PostgreSQL Replication Setup with Docker Compose

A ready-to-use Docker Compose configuration for setting up PostgreSQL 16 master-slave (primary-replica) replication with streaming replication and physical replication slots.

## Features

- ✅ PostgreSQL 16 primary-replica streaming replication
- ✅ Automatic replication user and slot creation
- ✅ Health checks for both primary and replica instances
- ✅ Configurable through environment variables
- ✅ Physical replication slots for reliable replication
- ✅ SCRAM-SHA-256 authentication
- ✅ Comprehensive logging configuration

## Quick Start

```bash
# Clone and start the replication setup
git clone https://github.com/tuanphuong-dev/postgres-rep-docker-compose.git
cd postgres-rep-docker-compose
docker-compose up -d

# Access primary database
docker exec -it postgres-primary psql -U postgres -d mydb

# Access replica database
docker exec -it postgres-replica psql -U postgres -d mydb
```

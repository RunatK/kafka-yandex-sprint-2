#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."


# messages
docker compose exec -T kafka1 kafka-topics --create --if-not-exists \
  --topic messages --partitions 3 --replication-factor 2 \
  --config min.insync.replicas=2 --bootstrap-server kafka1:9092

docker compose exec -T kafka1 kafka-configs --alter \
  --entity-type topics --entity-name messages --add-config min.insync.replicas=2 \
  --bootstrap-server kafka1:9092

docker compose exec -T kafka1 kafka-topics --describe \
  --topic messages --bootstrap-server kafka1:9092

# filtered_messages
docker compose exec -T kafka1 kafka-topics --create --if-not-exists \
  --topic filtered_messages --partitions 2 --replication-factor 2 \
  --config min.insync.replicas=2 --bootstrap-server kafka1:9092

docker compose exec -T kafka1 kafka-configs --alter \
  --entity-type topics --entity-name filtered_messages --add-config min.insync.replicas=2 \
  --bootstrap-server kafka1:9092

docker compose exec -T kafka1 kafka-topics --describe \
  --topic filtered_messages --bootstrap-server kafka1:9092

# blocked_users
docker compose exec -T kafka1 kafka-topics --create --if-not-exists \
  --topic blocked_users --partitions 2 --replication-factor 2 \
  --config min.insync.replicas=2 --bootstrap-server kafka1:9092

docker compose exec -T kafka1 kafka-configs --alter \
  --entity-type topics --entity-name blocked_users --add-config min.insync.replicas=2 \
  --bootstrap-server kafka1:9092

docker compose exec -T kafka1 kafka-topics --describe \
  --topic blocked_users --bootstrap-server kafka1:9092

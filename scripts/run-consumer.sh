#!/bin/bash

echo -e "\n\n==> Consume from east: Multi-region sync Replication reading from Leader in rack west-1 (topic: multi-region-sync-op-under-min-isr) \n"

docker-compose exec broker-east-6 kafka-consumer-perf-test --topic  multi-region-sync-op-under-min-isr \
    --messages 500 \
    --broker-list broker-west-1:19091,broker-east-6:19096 \
    --timeout 30000 \
    --consumer.config /etc/kafka/demo/consumer-west.config

echo -e "\n\n==> Consume from east: Multi-region sync Replication reading from Follower or Observers in rack east-1 (topic: multi-region-sync-op-under-min-isr) \n"

docker-compose exec broker-east-6 kafka-consumer-perf-test --topic multi-region-sync-op-under-min-isr \
    --messages 500 \
    --broker-list broker-west-1:19091,broker-east-6:19096 \
    --timeout 30000 \
    --consumer.config /etc/kafka/demo/consumer-east.config

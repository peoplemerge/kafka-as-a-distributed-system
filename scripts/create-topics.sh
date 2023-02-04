#!/bin/bash


echo -e "\n==> Creating topic multi-region-sync-op-under-min-isr"

docker-compose exec broker-west-1 kafka-topics  \
        --create \
        --bootstrap-server broker-west-1:19091 \
        --topic multi-region-sync-op-under-min-isr \
        --partitions 1 \
        --replica-placement /etc/kafka/demo/placement-multi-region-sync-op-under-min-isr.json \
        --config min.insync.replicas=3


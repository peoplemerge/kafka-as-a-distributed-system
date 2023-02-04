#!/bin/bash

echo -e "\n==> Describe topic: $topic\n"

docker-compose exec broker-east-6 kafka-topics --describe --bootstrap-server broker-east-6:19096 --topic multi-region-sync-op-under-min-isr


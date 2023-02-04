#!/bin/bash

cat << EOF
=========================
=	Base line	=
=========================

EOF

docker-compose exec broker-west-1 kafka-producer-perf-test --topic multi-region-sync-op-under-min-isr \
    --num-records 200 \
    --record-size 5000 \
    --throughput -1 \
    --producer-props \
        acks=all \
        bootstrap.servers=broker-west-1:19091,broker-east-6:19096 \
        compression.type=none \
        batch.size=8196


cat << EOF

===============================================================================
= Increase the batch.size and linger.ms, set client side receive.buffer.bytes =
= and send.buffer.bytes to OS default                                         =
= RHEL default: https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/5/html/tuning_and_optimizing_red_hat_enterprise_linux_for_oracle_9i_and_10g_databases/sect-oracle_9i_and_10g_tuning_guide-adjusting_network_settings-changing_network_kernel_settings         =
=	compression.type=none 						      =
=	batch.size=16392						      = 
= 	linger.ms=5 							      =
= 	receive.buffer.bytes=-1						      = 
= 	send.buffer.bytes=-1						      = 
===============================================================================

EOF

docker-compose exec broker-west-1 kafka-producer-perf-test --topic multi-region-sync-op-under-min-isr \
    --num-records 200 \
    --record-size 5000 \
    --throughput -1 \
    --producer-props \
        acks=all \
        bootstrap.servers=broker-west-1:19091,broker-east-6:19096 \
        compression.type=none \
        batch.size=16392 \
	linger.ms=5 \
	receive.buffer.bytes=-1 \
	send.buffer.bytes=-1 
	


cat << EOF

==============================================================
= Increase num.replica.fetchersto 2. The broker replica fetc =
= parameters neet to restart the brokers, can't be changed   =
= on run time           			             =
==============================================================

EOF

docker-compose exec broker-west-1 kafka-configs --bootstrap-server broker-west-1:19091,broker-east-6:19096 \
	--entity-type brokers --entity-default --alter \
	--add-config num.replica.fetchers=2
	


cat << EOF

===============================================================================
= Keep increasing ... 							      =
=       compression.type=zstd                                                 =
=       batch.size=32784                                                      =
=       linger.ms=5                                                           =
=       receive.buffer.bytes=16777216                                         =
=       send.buffer.bytes=16777216                                            =
===============================================================================

EOF

docker-compose exec broker-west-1 kafka-producer-perf-test --topic multi-region-sync-op-under-min-isr \
    --num-records 200 \
    --record-size 5000 \
    --throughput -1 \
    --producer-props \
        acks=all \
        bootstrap.servers=broker-west-1:19091,broker-east-6:19096 \
        compression.type=zstd \
        batch.size=32784 \
        linger.ms=5 \
        receive.buffer.bytes=16777216 \
        send.buffer.bytes=16777216 


cat << EOF

===============================================================================
= Change producer acks=from all to 1                                          =
=       compression.type=zstd                                                 =
=       batch.size=32784                                                      =
=       linger.ms=5                                                           =
=       receive.buffer.bytes=16777216                                         =
=       send.buffer.bytes=16777216                                            =
===============================================================================

EOF

docker-compose exec broker-west-1 kafka-producer-perf-test --topic multi-region-sync-op-under-min-isr \
    --num-records 200 \
    --record-size 5000 \
    --throughput -1 \
    --producer-props \
        acks=1 \
        bootstrap.servers=broker-west-1:19091,broker-east-6:19096 \
        compression.type=zstd \
        batch.size=32784 \
        linger.ms=5 \
        receive.buffer.bytes=16777216 \
        send.buffer.bytes=16777216


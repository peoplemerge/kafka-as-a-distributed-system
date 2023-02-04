# MRC-perf-tuning-demo-4-AOP

This is an addition from Tutorial: Multi-Region Clusters.

The setup is a production grade Confluent Multi-Region clusters, with 4 brokers, including 1 observer on each region (east-1 and west-1).

Injection 100ms network latency between east-1 and west-1 region. 

Tuning several parameters on OS TCP buffers, Kafka Client batching, and broker replica fetching parameters to see the variation of the performance of producer. 

Run consumer perf test against the leader on the remote region and the followers and observers on the local region, and compare the performance variation. 

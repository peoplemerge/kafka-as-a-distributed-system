# MRC-perf-tuning-demo-4-AOP

This is an addition from [Tutorial: Multi-Region Clusters](https://docs.confluent.io/platform/current/tutorials/examples/multiregion/docs/multiregion.html#tutorial-multi-region-clusters).

The cluster setup is a Confluent Multi-Region clusters with 2.5 regions. In the two full regions, each of them has 4 brokers, including 1 observer and 3 replicas.

Inject 100ms network latency between east-1 and west-1 region. 

Tune several parameters about OS TCP buffers, Kafka Client batching, and broker replica fetching parameters to demo the variation of the performance of Kafka producer. The tuning strategies follow the great talk from Anna McDonald in Kafka Summit 2021 - [A Tale of 2(n) Data Centers: Tuning Apache Kafka Clusters to Combat Latency](https://www.confluent.io/events/kafka-summit-americas-2021/a-tale-of-2-n-data-centers-tuning-apache-kafka-clusters-to-combat-latency)

Run consumer perf test against the leader on the remote region and the followers and observers on the local region, and compare the performance variation. 

To Start:
1. Clone the Repo:
`git clone git@github.com:janedeng/MRC-perf-tuning-demo-4-AOP.git`
2. Go to the directory
`cd MRC-perf-tuning-demo-4-AOP`
3. Run the start script
`./scripts/start.sh`

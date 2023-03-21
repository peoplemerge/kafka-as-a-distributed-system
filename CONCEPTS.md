## ACID Transactions 
1. Atomic: a transaction abort will discard incomplete writes
2. Consistent: your application invariants will always be maintained; for example, a ticket will can be sold to only one fan
3. Isolated: concurrent transactions are isolated from one another
4. Durable: once a transaction has committed, it won't be lost

/polly These appear to be database features. Which characteristic doesn't belong to a database? 
Atomic
Consistent
Isolated
Durable

### Isolated doesn't belong
Because it's up to your application to ensure it.
Your database vendor will send you on a choose-your-own-adventure of confusing nomenclature that differs from other vendors and academic papers.  Designing Data Intensive Applications covers these isolation levels pretty well: 
Read Committed
Snapshot Isolation with Repeatable Read
Serializable and 2 phase locking

## Replicas
Defitition: keeping a copy of the same data on multiple machines that are connected via a network

Why?
1. Lower latency
2. Keep working if something fails
3. Scale out reads

## Partitions
What if your data doesn't fit on one machine?  What if your throughput is more than one machine can handle?  Sharding is the process of breaking our dataset into partitions.
The goal is shared-nothing:
* More disks
* More CPU cores


## CAP theorem
The [CAP Theorem](https://www.the-paper-trail.org/page/cap-faq/) [illustrated](https://mwhittaker.github.io/blog/an_illustrated_proof_of_the_cap_theorem) says that it is impossible to build an implementation of read-write storage in an asynchronous network that satisfies all of the following three properties:

1. Availability - will a request made to the data store always eventually complete?
2. Consistency - will all executions of reads and writes seen by all nodes be atomic or linearizably consistent?
3. Partition tolerance - the network is allowed to drop any messages.

Choose two of these hard and fast rules.

In other words, given the reality of network partitions, you have to choose between consistency and availability.  Would you rather be able to write at all times, or block writing until order can be assured?


## Eventual Consistency
Let's choose scalability (an "AP" system). Amazon’s Dynamo relaxes consistency: "for a shopping cart, shoppers can always shop, and do so quickly.  And as Patriotic Americans, we know how vital it is to support Our Retail Destiny"

## Consistency
Consistency can mean one of a number of things:
1. Replica consistency - are all replicas up to date with a leader
2. ACID consistency - the database is in good shape
3. Consistent hashing - an algorithm to choose partitions from data
4. Linearizability - (CAP theorem) see below --v

### Linearizability
aka atomic consistency, strong consistency, immediate consistency, or external consistency

The system must appear as if there were only one copy of the data, and all operations are atomic, _even in an eventually consistend database_

After a write, clients must be able to see the value just written.  Stale results are not allowed.

## Kafka Replicas in Practice
1. Leader-follower model
2. ISR: in-sync replicas
3. `acks`: how many replicas from which you require an ack

## Further Reading
* [Designing Data-Intensive Systems (O'Reilly)](https://learning.oreilly.com/library/view/designing-data-intensive-applications/9781491903063)
* [Kafka Multi-Region Clusters](https://docs.confluent.io/platform/current/tutorials/examples/multiregion/docs/multiregion.html#tutorial-multi-region-clusters)
* [All things clock](https://medium.com/geekculture/all-things-clock-time-and-order-in-distributed-systems-logical-clocks-in-real-life-2-ad99aa64753)



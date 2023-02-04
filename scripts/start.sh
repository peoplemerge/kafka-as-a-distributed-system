#! /bin/bash

cat << EOF
==================================
     Creating docker image ...
==================================

EOF
scripts/build_docker_images.sh

cat << EOF

==================================
     Start docker ...
==================================

EOF
docker-compose up -d
sleep 10

cat << EOF

==================================
     Inject network latency
==================================

EOF
./scripts/latency_docker.sh

cat << EOF

==================================
     Create topic ...
==================================

EOF

./scripts/create-topics.sh
./scripts/describe-topics.sh

cat << EOF

==================================
   Prpoducer Perf Comparison
   with different parameters
   under high network latency
==================================

EOF
./scripts/run-producer.sh

cat << EOF

==================================
   Consumer Perf Comparison
   reading from the remote leader
   vs reading from the local Follower
==================================

EOF
./scripts/run-consumer.sh


#!/bin/bash
microk8s kubectl -n exec -it mongo-0 -- mongosh <<EOF
rs.initiate()
var cfg = rs.conf()
EOF
sleep 5
microk8s kubectl -n exec -it mongo-0 -- mongosh <<EOF
cfg.members[0].host="mongo-0.mongo:27017"
EOF
sleep 5
microk8s kubectl -n exec -it mongo-0 -- mongosh <<EOF
rs.reconfig(cfg)
EOF
microk8s kubectl -n exec -it mongo-0 -- mongosh <<EOF
rs.add("mongo-1.mongo:27017");
EOF
sleep 5
microk8s kubectl -n exec -it mongo-0 -- mongosh <<EOF
rs.add("mongo-2.mongo:27017");
EOF
sleep 5
microk8s kubectl -n exec -it mongo-0 -- mongosh <<EOF
rs.status();
EOF

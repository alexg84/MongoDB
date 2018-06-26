#!/bin/sh
cat <<'EOF' >> /etc/yum.repos.d/mongodb.repo
[mongodb-org-3.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.4.asc

EOF

sudo yum -y install mongodb-org

cat <<'EOF' > /etc/mongod.conf
# mongod.conf
# for documentation of all options, see:
#   http://docs.mongodb.org/manual/reference/configuration-options/
# where to write logging data.
systemLog:
  destination: file
  logAppend: true
  path: /var/log/mongodb/mongod.log
# Where and how to store data.
storage:
  dbPath: /var/lib/mongo
  journal:
    enabled: true
#  engine:
#  mmapv1:
#  wiredTiger:
# how the process runs
processManagement:
  fork: true  # fork and run in background
  pidFilePath: /var/run/mongodb/mongod.pid  # location of pidfile
# network interfaces
net:
  port: 27017
#  bindIp: 127.0.0.1  # Listen to local interface only, comment to listen on all interfaces.
#security:
#operationProfiling:
replication:
  replSetName: "myreplica01"
#sharding:
## Enterprise-Only Options
#auditLog:
#snmp:

EOF

sudo systemctl restart mongod
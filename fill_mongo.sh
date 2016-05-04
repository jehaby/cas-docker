#!/usr/bin/env bash

set -a
source .env

docker cp ./mongo-seed/mongodump.tgz ${PROJECT}mongo:/tmp
docker-compose exec mongo bash -c 'tar -C /tmp -xf /tmp/mongodump.tgz && mongorestore /tmp/mongodb/test/ && rm -r /tmp/{mongodb,mongodump.tgz}'

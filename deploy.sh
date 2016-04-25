#!/bin/bash

# variables defined in .env will be exported into this script's environment:
set -a
source .env

# Let's delete all containers that have a `my-project_` prefix:
# (by deleting/re-deploying our containers, this script is now idempotent!):

rm docker-compose.yml
docker rm -f `docker ps -aq -f name=$PROJECT_*`

# Now lets populate our nginx config templates to get an actual nginx config
# (which will be loaded into our nginx container):

envsubst '$CAS_DOMAINS' < configs/cas.conf.tpl > configs/cas.conf
envsubst '$MY_DOMAINS' < configs/my.conf.tpl > configs/my.conf

# Let's populate the variables in our compose file template,
# then deploy it!

cat compose-template.yml | envsubst > docker-compose.yml
docker-compose -p my-project_ up

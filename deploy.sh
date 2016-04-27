#!/usr/bin/env bash

# variables defined in .env will be exported into this script's environment:
set -a
source .env

get_my_ip() {
    echo $(ip -o -4 addr list ${1:-eth0} | awk '{print $4}' | cut -d/ -f1)
}

for ((i=1;i<=$#;i++)); 
do
    if [ ${!i} = "-i" ]
    then ((i++))
	INTERFACE=${!i};
    elif [ ${!i} = "-c" ];
    then ((i++))
	COMPOSE_ARGUMENTS=${!i};
    fi    
done

HOST_IP=$(get_my_ip $INTERFACE)

# Let's delete all containers that have a `my-project_` prefix:
# (by deleting/re-deploying our containers, this script is now idempotent!):
docker rm -f $(docker ps -aq -f name=${PROJECT}_*)

# Now lets populate our nginx config templates to get an actual nginx config
# (which will be loaded into our nginx container):
envsubst '$CAS_DOMAINS:$PROJECT' < configs/cas.conf.tpl > configs/cas.conf
envsubst '$MY_DOMAINS:$PROJECT' < configs/my.conf.tpl > configs/my.conf

# Let's populate the variables in our compose file template,
# then deploy it!
cat compose-template.yml | envsubst > docker-compose.yml
docker-compose up -d $COMPOSE_ARGUMENTS

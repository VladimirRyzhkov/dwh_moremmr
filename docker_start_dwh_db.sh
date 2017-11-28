#!/bin/sh
CONTAINER_VOLUME="/var/lib/pgsql"
HOST_VOLUME=mmmr_dwh_db_volume
IMAGE="centos_pgsql/mmmr"
CONTAINER="mmmr_dwh_db"

docker build --rm -t "$IMAGE" .
docker run -it -d -p 5432:5432 --name="$CONTAINER" -v $HOST_VOLUME:"$CONTAINER_VOLUME" "$IMAGE"
docker exec -it "$CONTAINER" bash
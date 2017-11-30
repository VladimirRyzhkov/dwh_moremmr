#!/bin/bash
DB_NAME=$1
BACKUP_DIR=$2

if [ ! $DB_NAME ]; then
    echo "Specify database name in the 1-st parameter!" 1>&2
    exit 1;
fi;

if [ ! "$BACKUP_DIR" ]; then
    echo "Specify full path to docker container's backup directory in the 2-nd parameter!" 1>&2
    exit 1;
fi;

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/docker_dwh_envars.sh
docker exec -it ${DOC_DWH_CONTAINER} sudo -iu postgres /usr/bin/pg_restore.sh $DB_NAME "$BACKUP_DIR"
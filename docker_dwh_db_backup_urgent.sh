#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/docker_dwh_envars.sh
docker exec -it ${DOC_DWH_CONTAINER} sudo -iu postgres /usr/bin/pg_backup.sh
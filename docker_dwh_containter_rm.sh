#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/docker_dwh_envars.sh
docker stop ${DOC_DWH_CONTAINER}
docker rm ${DOC_DWH_CONTAINER}
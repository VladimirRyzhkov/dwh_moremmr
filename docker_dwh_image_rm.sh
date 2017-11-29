#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/docker_dwh_envars.sh
. ${DIR}/docker_dwh_containter_rm.sh
docker rmi ${DOC_DWH_IMAGE}
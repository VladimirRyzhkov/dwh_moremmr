#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/docker_dwh_envars.sh
docker build --rm -t ${DOC_DWH_IMAGE} .
. ${DIR}/docker_dwh_containter_start.sh
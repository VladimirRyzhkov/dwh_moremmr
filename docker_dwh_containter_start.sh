#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/docker_dwh_envars.sh
docker run -it -d -p 5432:5432 --name=${DOC_DWH_CONTAINER} -v ${DOC_DWH_HOST_VOLUME}:${DOC_DWH_CONTAINER_VOLUME} ${DOC_DWH_IMAGE}
DOC_DWH_HOST_VOLUME_PATH="$(docker volume inspect --format '{{ .Mountpoint }}' ${DOC_DWH_HOST_VOLUME})"
export DOC_DWH_HOST_VOLUME_PATH
docker exec -it ${DOC_DWH_CONTAINER} bash
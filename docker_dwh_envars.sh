#!/bin/bash
DOC_DWH_CONTAINER_VOLUME="/var/lib/pgsql"
export DOC_DWH_CONTAINER_VOLUME
DOC_DWH_HOST_VOLUME=mmmr_dwh_db_volume
export DOC_DWH_HOST_VOLUME
DOC_DWH_IMAGE="centos_pgsql/mmmr"
export DOC_DWH_IMAGE
DOC_DWH_CONTAINER="mmmr_dwh_db"
export DOC_DWH_CONTAINER
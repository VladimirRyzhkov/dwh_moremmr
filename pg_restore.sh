#!/bin/bash
# Restore DB backup than had been made by pg_backup*.sh
# 1-st parameter: data base name
# 2-nd parameter: full path to the dirictory which contains <DB_NAME.sgl.gz> file (e.g. /var/lib/pgsql/backups/2017-11-30-daily)
PGENGINE=/usr/pgsql-9.6/bin
DB_NAME=$1
BACKUP_DIR=$2

###########################
#### PRE-RESTORE CHECKS ###
###########################
if [ ! $DB_NAME ]; then
    echo "Database name for restore is not specified in the 1-st parameter!" 1>&2
    exit 1;
fi;

if [ $DB_NAME = "globals" ] then
    echo "Database globals does not exist. Try to gunzip globals.sql.gz and run manually its commands." 1>&2
    exit 1;
fi

if [ ! $BACKUP_DIR ]; then
    echo "Backup directory $BACKUP_DIR is not specified in the 2-nd parameter!" 1>&2
    exit 1;
fi;

if [ ! -d $BACKUP_DIR ]; then
    echo "Backup directory $BACKUP_DIR (from the 2-nd parameter) does not exist in the docker container!" 1>&2
    exit 1;
fi
###########################
#### START THE RESTORE ####
###########################
$PGENGINE/dropdb -U postgres $DB_NAME
$PGENGINE/createdb -U postgres $DB_NAME
gunzip -c $BACKUP_DIR/$DB_NAME.sql.gz | psql -U postgres $DB_NAME
2017 November 27 (@RyzhkovVladimir)
 Initial docker files are from: https://github.com/CentOS/CentOS-Dockerfiles/tree/master/postgres/centos7
 Some postgresql.conf parameters calculated by PgTune as for DataWarehous using with 5 connections and 2GB RAM:
   max_connections = 5
   shared_buffers = 512MB
   effective_cache_size = 1536MB
   work_mem = 52428kB
   maintenance_work_mem = 256MB
   min_wal_size = 4GB
   max_wal_size = 8GB
   checkpoint_completion_target = 0.9
   wal_buffers = 16MB
   default_statistics_target = 500
 Docker file configured for PostgreSQL 9.6
 postgresql-setup has been took from original PostgreSQL 9.6 and tuned a little bit
 supervisord.conf tuned to postgresql9.6


Original readme

dockerfiles-centos-postgres
===========================

Dockerfile to build PostgreSQL on CentOS 7

Setup
-----

To build the image

    # docker build --rm -t <yourname/postgresql .


Launching PostgreSQL
--------------------

#### Quick Start (not recommended for production use)

    docker run --name=postgresql -d -p 5432:5432 <yourname>/postgresql


To connect to the container as the administrative `postgres` user:

    docker run -it --rm --volumes-from=postgresql <yourname>/postgres sudo -u
    postgres -H psql


Creating a database at launch
-----------------------------

You can create a postgresql superuser at launch by specifying `DB_USER` and
`DB_PASS` variables. You may also create a database by using `DB_NAME`. 

    docker run --name postgresql -d \
    -e 'DB_USER=username' \
    -e 'DB_PASS=ridiculously-complex_password1' \
    -e 'DB_NAME=my_database' \
    <yourname>/postgresql

To connect to your database with your newly created user:

    psql -U username -h $(docker inspect --format {{.NetworkSettings.IPAddress}} postgresql)
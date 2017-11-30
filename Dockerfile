# "ported" by Vladimir Ryzhkov <ryzhkov.vlad@gmail.com>
#   from https://github.com/CentOS/CentOS-Dockerfiles/tree/master/postgres/centos7 which
# "ported" by Adam Miller <maxamillion@fedoraproject.org> from
#   https://github.com/fedora-cloud/Fedora-Dockerfiles
#
# Originally written for Fedora-Dockerfiles by
#   scollier <scollier@redhat.com>

FROM centos:centos7
MAINTAINER The CentOS Project <cloud-ops@centos.org>

RUN yum -y update; yum clean all
RUN yum -y install deltarpm.x86_64 sudo.x86_64 epel-release.noarch; yum clean all
RUN yum -y install https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-6-x86_64/pgdg-centos96-9.6-3.noarch.rpm
RUN yum -y install postgresql96-server.x86_64 postgresql96.x86_64 postgresql96-contrib.x86_64 postgresql96-libs.x86_64 postgresql96-odbc.x86_64 postgresql96-devel.x86_64 postgresql-upgrade.x86_64 supervisor.noarch pwgen; yum clean all
RUN yum -y install perl-PerlIO-gzip.x86_64; yum clean all
#RUN yum -y install vim; yum clean all

ADD ./postgresql-setup /usr/bin/postgresql-setup
ADD ./supervisord.conf /etc/supervisord.conf
ADD ./start_postgres.sh /start_postgres.sh

#Postgres backup files
ADD ./pg_backup.config /usr/bin/pg_backup.config
ADD ./pg_backup.sh /usr/bin/pg_backup.sh
ADD ./pg_backup_rotated.sh /usr/bin/pg_backup_rotated.sh
ADD ./pg_restore.sh /usr/bin/pg_restore.sh

#Sudo requires a tty. fix that.
RUN sed -i 's/.*requiretty$/#Defaults requiretty/' /etc/sudoers
RUN chmod +x /usr/bin/postgresql-setup
RUN chmod +x /start_postgres.sh

RUN /usr/bin/postgresql-setup initdb

ADD ./postgresql.conf /var/lib/pgsql/data/postgresql.conf

RUN chown -v postgres.postgres /var/lib/pgsql/data/postgresql.conf

#RUN echo "host    all             all             0.0.0.0/0               md5" >> /var/lib/pgsql/data/pg_hba.conf
#RUN sed -i 's/^host\s*all\s*all\s*127\.0\.0\.1\/32\s*ident/host    all             all             127.0.0.1\/32            md5/g' /var/lib/pgsql/data/pg_hba.conf
#RUN sed -i 's/^local\s*all\s*all\s*peer/local   all             all                                     md5/g' /var/lib/pgsql/data/pg_hba.conf
#RUN sed -i 's/^host\s*all\s*all\s*\:\:1\/128\s*ident/host    all             all             ::1\/128                 md5/g' /var/lib/pgsql/data/pg_hba.conf

WORKDIR /var/lib/pgsql
VOLUME ["/var/lib/pgsql"]

EXPOSE 5432

CMD ["/bin/bash", "/start_postgres.sh"]

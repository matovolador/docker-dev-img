FROM ubuntu:18.04

LABEL maintainer="Matias Garafoni matias@bossnode.com"

# copy system setup script and execute
COPY ubuntu-setup.sh /home/ubuntu-setup.sh
RUN chmod +x /home/ubuntu-setup.sh
RUN /bin/bash /home/ubuntu-setup.sh

# install tzdata non-interactive
COPY tzdata.sh /home/tzdata.sh
RUN chmod +x /home/tzdata.sh
RUN /bin/bash /home/tzdata.sh

## install mysql-client
# RUN apt install mysql-client -y
## OR  optional install mysql-server (client is installed with ubuntu-setup.sh)
COPY mysql_config.sh /home/mysql_config.sh
RUN chmod +x /home/mysql_config.sh
RUN /bin/bash /home/mysql_config.sh

# random port so it can start without annoying -already used- messages...
EXPOSE 549

# not executing flask app on docker dev machine
# ENTRYPOINT [ "python" ]
# CMD [ "app/__init__.py" ]
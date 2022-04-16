FROM louislam/uptime-kuma

####################################################################################
### Install OpenSSH and set the password for root to "Docker!"
### This will make it possible to debug the container in the App Service SCM tooling
####################################################################################
RUN apt-get update \
     && apt-get install -y openssh-server htop dos2unix iputils-ping curl wget\
     && echo "root:Docker!" | chpasswd
# Copy the sshd_config file to the /etc/ssh/ directory
COPY ssh/printenv.sh /etc/ssh/
COPY ssh/sshd_config /etc/ssh/
RUN dos2unix /etc/ssh/*

# Copy and configure the ssh_setup file
COPY ssh/ssh_setup.sh /tmp/ssh_setup.sh
RUN dos2unix /tmp/ssh_setup.sh \
    && chmod +x /tmp/ssh_setup.sh \
    && (sleep 1;/tmp/ssh_setup.sh 2>&1 > /dev/null)
EXPOSE 2222
####################################################################################

WORKDIR /app

COPY . .

# RUN cp -r /app /home/app

# WORKDIR /home/app

EXPOSE 80


# VOLUME ["/home/app/data"]

# ENTRYPOINT ["/usr/bin/dumb-init", "--", "extra/entrypoint.sh"]


COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN dos2unix /usr/local/bin/docker-entrypoint.sh \
    && chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

# CMD ["node", "server/server.js"]

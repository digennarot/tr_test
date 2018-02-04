FROM ubuntu:latest

RUN apt-get update && apt-get -y upgrade && DEBIAN_FRONTEND=noninteractive apt-get -y install \
    apache2 php7.0 libapache2-mod-php7.0 curl netcat-traditional iputils-ping && \
    rm -rf /var/lib/apt/lists/*

RUN a2dismod mpm_worker
RUN a2enmod mpm_prefork
RUN a2enmod php7.0
RUN a2enmod proxy
RUN a2enmod proxy_fcgi

RUN rm -rf /var/www/*

COPY conf/apache2.conf /etc/apache2/apache2.conf

RUN curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.0.1-amd64.deb
RUN dpkg -i filebeat-6.0.1-amd64.deb
RUN rm -rf filebeat-6.0.1-amd64.deb
COPY conf/filebeat.yml /etc/filebeat/filebeat.yml
COPY conf/apache2.yml /etc/filebeat/modules.d/apache2.yml
RUN filebeat modules enable apache2
RUN filebeat -e

ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
FROM centos:7
COPY conf/install.sh /tmp/install.sh
RUN sh /tmp/install.sh
COPY data/index.php /var/www/

RUN curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.1.3-x86_64.rpm
RUN rpm -ivh filebeat-6.1.3-x86_64.rpm
RUN rm -rf filebeat-6.1.3-x86_64.rpm

CMD ["php-fpm","-F","--pid","/var/run/php-fpm.pid","-c","/etc/php-fpm.d/fpm-tr.conf"]

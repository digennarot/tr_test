# https://github.com/elastic/logstash-docker
FROM docker.elastic.co/logstash/logstash-oss:6.1.3

COPY --chown=logstash pipeline/logstash.conf /usr/share/logstash/pipeline/logstash.conf

#RUN logstash-plugin install logstash-filter-json
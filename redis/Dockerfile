FROM redis:latest

RUN apt-get update && apt-get install -y ssh && rm -rf /var/lib/apt/lists/*
RUN cat /dev/zero | ssh-keygen -q -N ""
COPY conf/id_rsa /root/.ssh/
COPY conf/id_rsa.pub /root/.ssh/
COPY conf/authorized_keys /root/.ssh/
COPY data/rediscleaner.sh /root/
RUN chmod 755  /root/rediscleaner.sh
COPY conf/redis.conf /usr/local/etc/redis/redis.conf
ENTRYPOINT service ssh restart && redis-server /usr/local/etc/redis/redis.conf
#ENTRYPOINT [ "redis-server", "/usr/local/etc/redis/redis.conf" ]

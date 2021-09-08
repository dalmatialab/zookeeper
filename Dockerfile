FROM ubuntu:20.04
LABEL maintainer="dalmatialab"

# Install tzdata and set right timezone
ENV DEBIAN_FRONTEND="noninteractive"
RUN apt update && apt-get -y install tzdata
ENV TZ=Europe/Zagreb

# Java installation
RUN apt-get update && apt-get install -y openjdk-8-jdk wget

# Environment version variables
ENV ZOOKEEPER_VERSION 3.6.3

# Environment home variables
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV ZOOKEEPER_HOME=/opt/zookeeper 

# Adding on path
ENV PATH $JAVA_HOME/bin:$PATH
ENV PATH $ZOOKEEPER_HOME/bin:$PATH

# Zookeeper installation
RUN mkdir -p /opt/zookeeper
RUN cd /opt/zookeeper && wget https://downloads.apache.org/zookeeper/zookeeper-$ZOOKEEPER_VERSION/apache-zookeeper-$ZOOKEEPER_VERSION-bin.tar.gz && tar -xvzf apache-zookeeper-$ZOOKEEPER_VERSION-bin.tar.gz  --strip-components 1 && rm apache-zookeeper-$ZOOKEEPER_VERSION-bin.tar.gz

EXPOSE 2181 2888 3888 8080

# Copy configuration generator script to bin
COPY lib /opt/zookeeper/bin/

RUN apt-get update && apt-get install netcat-traditional

RUN chmod a+x $ZOOKEEPER_HOME/bin/start-zookeeper
RUN chmod a+x $ZOOKEEPER_HOME/bin/zookeeper-ready
RUN chmod a+x $ZOOKEEPER_HOME/bin/zookeeper-metrics

CMD ["sh","-c","start-zookeeper --servers=1 --data_dir=/var/lib/zookeeper/data --data_log_dir=/var/lib/zookeeper/data/log --conf_dir=/opt/zookeeper/conf --client_port=2181 --election_port=3888 --server_port=2888 --tick_time=2000 --init_limit=10 --sync_limit=5 --heap=512M --max_client_cnxns=60 --snap_retain_count=3 --purge_interval=12 --max_session_timeout=40000 --min_session_timeout=4000 --log_level=INFO"]
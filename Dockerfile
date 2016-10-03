FROM develar/java
MAINTAINER Oleg Fedoseev <oleg.fedoseev@me.com>

ENV HADOOP_VERSION  2.6.0
ENV HADOOP_HOME     /usr/local/hadoop

ENV HIVE_VERSION    2.1.0
ENV HIVE_HOME       /usr/local/hive

ENV PATH            $PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$HIVE_HOME/bin:$HIVE_HOME/sbin

RUN addgroup hadoop && adduser -G hadoop -D -H hadoop && \
    addgroup hive && adduser -G hive -D -H hive
RUN apk add --update curl bash && \
    curl -kL http://www-eu.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz | tar -zx -C /tmp && \
    mv /tmp/hadoop-$HADOOP_VERSION /usr/local/hadoop && chown -R hadoop:hadoop /usr/local/hadoop && \
    curl -kL http://www-eu.apache.org/dist/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz | tar -zx -C /tmp && \
    mv /tmp/apache-hive-$HIVE_VERSION-bin/ /usr/local/hive && chown -R hive:hive /usr/local/hive && \
    curl -kL https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.39.tar.gz | tar -xz -C /tmp && \
    mv /tmp/mysql-connector-java-5.1.39/mysql-connector-java-5.1.39-bin.jar $HIVE_HOME/lib && \
    apk del curl && rm -rf /tmp/* /var/cache/apk/*

EXPOSE 10000 10002
USER hive

# /usr/local/hive/bin/hive --service hiveserver2 --hiveconf hive.root.logger=INFO,console
ENTRYPOINT ["/usr/local/hive/bin/hive"]
CMD ["--service", "hiveserver2", "--hiveconf", "hive.root.logger=INFO,console"]

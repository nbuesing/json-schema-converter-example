FROM confluentinc/cp-kafka-connect:5.5.0

ENV CONNECT_PLUGIN_PATH="/usr/share/java,/usr/share/confluent-hub-components"


#RUN confluent-hub install --no-prompt debezium/debezium-connector-postgresql:0.8.3
# rm -fr /usr/share/java/kafka-connect-jdbc 


RUN \
    rm -fr /usr/share/java/kafka-connect-activemq && \
    rm -fr /usr/share/java/kafka-connect-ibmmq && \
    rm -fr /usr/share/java/kafka-connect-jms && \
    rm -fr /usr/share/java/kafka-connect-s3 

RUN \
    cd /usr/share/java/kafka-connect-jdbc && \
    curl -Lsk https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.48.tar.gz | tar xzv --strip-components=1 --no-same-owner "mysql-connector-java-5.1.48/mysql-connector-java-5.1.48-bin.jar"



RUN \
    confluent-hub install --no-prompt debezium/debezium-connector-mysql:latest



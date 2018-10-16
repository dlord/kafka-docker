FROM openjdk:8-jdk-alpine

RUN apk add --no-cache curl bash

ENV KAFKA_VERSION=2.0.0 \
    KAFKA_SCALA_VERSION=2.11

RUN mkdir -p /opt \
    && curl -SL http://www.us.apache.org/dist/kafka/$KAFKA_VERSION/kafka_$KAFKA_SCALA_VERSION-$KAFKA_VERSION.tgz | tar xzv -C /opt \
    && mkdir -p /var/lib/kafka \
    && ln -s /opt/kafka_$KAFKA_SCALA_VERSION-$KAFKA_VERSION /opt/kafka

COPY entrypoint.sh /
COPY server.properties /opt/kafka/config/

VOLUME ["/var/lib/kafka"]
EXPOSE 9092

ENTRYPOINT ["/entrypoint.sh"]
CMD ["run"]

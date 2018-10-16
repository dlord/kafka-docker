#!/bin/bash

run_kafka() {
    if [ -z $KAFKA_ID ]; then
        echo "no KAFKA_ID found. Getting from hostname"
        [[ ! `hostname` =~ -([0-9]+)$ ]] && echo "Unable to get KAFKA_ID from hostname!" && exit 1
        ordinal=${BASH_REMATCH[1]}
        
        KAFKA_ID=$((1 + $ordinal))
    fi

    echo "broker.id=$KAFKA_ID" >> /opt/kafka/config/server.properties
    echo "zookeeper.connect=$ZK_CONNECT" >> /opt/kafka/config/server.properties
    echo "log.dirs=/var/lib/kafka" >> /opt/kafka/config/server.properties

    exec /opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties
}

case "$1" in
    run)
        shift 1
        run_kafka "$@"
        ;;
    *)
        exec "$@"
esac

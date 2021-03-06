FROM changel/java:jre8.144.jce

ARG kafka_version=2.12-2.0.0

MAINTAINER changel <changel@changel.cn>

ENV SET_KAFKA_BROKER_ID=0 \
	SET_KAFKA_num_network_threads=3 \
	SET_KAFKA_num_io_threads=8 \
	SET_KAFKA_socket_send_buffer_bytes=102400 \
	SET_KAFKA_socket_receive_buffer_bytes=102400 \
	SET_KAFKA_socket_request_max_bytes=104857600 \
	SET_KAFKA_log_dirs=/tmp/kafka-logs \
	SET_KAFKA_num_partitions=1 \
	SET_KAFKA_num_recovery_threads_per_data_dir=1 \
	SET_KAFKA_offsets_topic_replication_factor=1 \
	SET_KAFKA_transaction_state_log_replication_factor=1 \
	SET_KAFKA_transaction_state_log_min_isr=1 \
	SET_KAFKA_log_retention_hours=168 \
	SET_KAFKA_log_segment_bytes=1073741824 \
	SET_KAFKA_log_retention_check_interval_ms=300000 \
	SET_KAFKA_zookeeper_connect=zookeeper:2181 \
	SET_KAFKA_zookeeper_connection_timeout_ms=6000 \
	SET_KAFKA_group_initial_rebalance_delay_ms=0 \
	SET_KAFKA_LISTENER_SECURITY_PROTOCOL_MAP=INSIDE:PLAINTEXT,OUTSIDE:PLAINTEXT \
	SET_KAFKA_LISTENERS=INSIDE://:9092,OUTSIDE://:9094 \
	SET_KAFKA_INTER_BROKER_LISTENER_NAME=INSIDE

RUN set -ex \
	&& apk add --no-cache curl \
	&& curl -sSL https://www.changel.cn/repo/kafka/kafka_${kafka_version}.tgz -o /tmp/kafka.tgz \
	&& tar zxf /tmp/kafka.tgz -C /usr/local \
	&& ln -sf /usr/local/kafka_${kafka_version} /usr/local/kafka \
	&& rm -f /tmp/kafka.tgz

ENV PATH=$PATH:/usr/local/kafka/bin

ADD auto-config.sh /usr/local/bin/

CMD ["auto-config.sh"]
FROM rabbitmq:management

# 安装延迟消息插件
RUN apt-get update && apt-get install -y curl && \
    curl -Lo /plugins/rabbitmq_delayed_message_exchange-3.13.0.ez \
    https://github.com/rabbitmq/rabbitmq-delayed-message-exchange/releases/download/v3.13.0/rabbitmq_delayed_message_exchange-3.13.0.ez && \
    chmod 644 /plugins/rabbitmq_delayed_message_exchange-3.13.0.ez && \
    rabbitmq-plugins enable --offline rabbitmq_management rabbitmq_delayed_message_exchange

# 设置环境变量（使用外部注入）
ENV RABBITMQ_DEFAULT_PASS=${RABBITMQ_DEFAULT_PASS} \
    RABBITMQ_DEFAULT_USER=${RABBITMQ_DEFAULT_USER} \
    RABBITMQ_NODENAME=${RABBITMQ_NODENAME} \
    RABBITMQ_PRIVATE_URL=${RABBITMQ_PRIVATE_URL} \
    RABBITMQ_URL=${RABBITMQ_URL}

# 启动命令
CMD ["/bin/sh", "-c", "CONFIG_PATH=/etc; SYSTEM_FILE=hosts; \
    echo 127.0.0.1 rabbitmq >> ${CONFIG_PATH}/${SYSTEM_FILE} && \
    echo 'management.tcp.ip = ::' >> /etc/rabbitmq/conf.d/10-defaults.conf && \
    docker-entrypoint.sh rabbitmq-server"]

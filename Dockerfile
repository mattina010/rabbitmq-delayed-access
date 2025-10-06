# 使用 RabbitMQ 4.1.4 管理镜像（自带 Web UI）
FROM rabbitmq:4.1.4-management

# 设置环境变量（这些值在运行容器时可被注入）
ENV RABBITMQ_DEFAULT_PASS=${RABBITMQ_DEFAULT_PASS} \
    RABBITMQ_DEFAULT_USER=${RABBITMQ_DEFAULT_USER} \
    RABBITMQ_NODENAME=${RABBITMQ_NODENAME} \
    RABBITMQ_PRIVATE_URL=${RABBITMQ_PRIVATE_URL} \
    RABBITMQ_URL=${RABBITMQ_URL}

# 确保配置目录存在
RUN mkdir -p /etc/rabbitmq/conf.d /plugins

# 安装 curl 以下载延迟消息插件
RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates && rm -rf /var/lib/apt/lists/*

# 下载并启用 rabbitmq_delayed_message_exchange 插件 v4.1.0
RUN set -eux; \
    PLUGIN_VERSION=4.1.0; \
    PLUGIN_URL="https://github.com/rabbitmq/rabbitmq-delayed-message-exchange/releases/download/v${PLUGIN_VERSION}/rabbitmq_delayed_message_exchange-${PLUGIN_VERSION}.ez"; \
    echo "Downloading delayed message plugin from ${PLUGIN_URL}"; \
    curl -fSL -o /plugins/rabbitmq_delayed_message_exchange-${PLUGIN_VERSION}.ez "${PLUGIN_URL}"; \
    chmod 644 /plugins/rabbitmq_delayed_message_exchange-${PLUGIN_VERSION}.ez; \
    rabbitmq-plugins enable --offline rabbitmq_management rabbitmq_delayed_message_exchange

# 暴露 AMQP 和管理端口
EXPOSE 5672 15672

# 启动命令（按你的要求）
CMD ["/bin/sh", "-c", "CONFIG_PATH=/etc; SYSTEM_FILE=hosts; \
    echo 127.0.0.1 rabbitmq >> ${CONFIG_PATH}/${SYSTEM_FILE} && \
    echo 'management.tcp.ip = ::' >> /etc/rabbitmq/conf.d/10-defaults.conf && \
    docker-entrypoint.sh rabbitmq-server"]

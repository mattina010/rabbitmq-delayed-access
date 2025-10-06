# 基于官方 RabbitMQ 镜像
FROM rabbitmq:latest

# 定义环境变量（只定义变量名，不填具体值，可在部署时注入）
ENV RABBITMQ_DEFAULT_PASS=${RABBITMQ_DEFAULT_PASS} \
    RABBITMQ_DEFAULT_USER=${RABBITMQ_DEFAULT_USER} \
    RABBITMQ_NODENAME=${RABBITMQ_NODENAME} \
    RABBITMQ_PRIVATE_URL=${RABBITMQ_PRIVATE_URL} \
    RABBITMQ_URL=${RABBITMQ_URL}

# 创建 RabbitMQ 配置目录
RUN mkdir -p /etc/rabbitmq/conf.d

# 启用管理插件和延迟消息插件
RUN rabbitmq-plugins enable --offline rabbitmq_management rabbitmq_delayed_message_exchange

# 暴露端口
EXPOSE 5672 15672

# 启动命令：动态引用环境变量
CMD ["/bin/sh", "-c", "CONFIG_PATH=/etc; SYSTEM_FILE=hosts; \
    echo 127.0.0.1 rabbitmq >> ${CONFIG_PATH}/${SYSTEM_FILE} && \
    echo 'management.tcp.ip = ::' >> /etc/rabbitmq/conf.d/10-defaults.conf && \
    docker-entrypoint.sh rabbitmq-server"]

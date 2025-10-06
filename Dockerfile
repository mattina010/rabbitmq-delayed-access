# 基于官方 RabbitMQ 镜像（包含插件功能）
FROM rabbitmq:latest

# 设置环境变量（根据截图）
ENV RABBITMQ_DEFAULT_PASS=test \
    RABBITMQ_DEFAULT_USER=LrVun3erXvpa84on \
    RABBITMQ_NODENAME=rabbit@rabbitmq \
    RABBITMQ_PRIVATE_URL=amqp://LrVun3erXvpa84on:test@rabbitmq.railway.internal:5672 \
    RABBITMQ_URL=amqp://LrVun3erXvpa84on:test@switchyard.proxy.rlwy.net:31077

# 创建 RabbitMQ 配置目录（确保存在）
RUN mkdir -p /etc/rabbitmq/conf.d

# 启用 RabbitMQ 管理界面和延迟消息插件
RUN rabbitmq-plugins enable --offline rabbitmq_management rabbitmq_delayed_message_exchange

# 暴露端口
# 5672  -> AMQP
# 15672 -> Web UI
EXPOSE 5672 15672

# 启动命令
CMD ["/bin/sh", "-c", "CONFIG_PATH=/etc; SYSTEM_FILE=hosts; echo 127.0.0.1 rabbitmq >> ${CONFIG_PATH}/${SYSTEM_FILE} && echo 'management.tcp.ip = ::' >> /etc/rabbitmq/conf.d/10-defaults.conf && docker-entrypoint.sh rabbitmq-server"]

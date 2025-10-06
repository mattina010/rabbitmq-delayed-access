FROM rabbitmq:4.1.4-management

# 下载延迟消息插件 (RabbitMQ 4.1.x 对应 v4.1.0)
ADD https://github.com/rabbitmq/rabbitmq-delayed-message-exchange/releases/download/v4.1.0/rabbitmq_delayed_message_exchange-4.1.0.ez /plugins/

# 启用插件
RUN rabbitmq-plugins enable --offline rabbitmq_delayed_message_exchange

# 允许 guest 用户远程访问
RUN echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.conf

# 暴露端口
EXPOSE 5672 15672

# 启动命令
CMD /bin/sh -c "CONFIG_PATH=/etc; SYSTEM_FILE=hosts;     echo 127.0.0.1 rabbitmq >> ${CONFIG_PATH}/${SYSTEM_FILE} &&     echo management.tcp.ip = :: >> /etc/rabbitmq/conf.d/10-defaults.conf &&     docker-entrypoint.sh rabbitmq-server"

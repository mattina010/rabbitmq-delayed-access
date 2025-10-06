FROM rabbitmq:4.1.4-management

# 下载延迟消息插件并设置权限
ADD https://github.com/rabbitmq/rabbitmq-delayed-message-exchange/releases/download/v4.1.0/rabbitmq_delayed_message_exchange-4.1.0.ez /opt/rabbitmq/plugins/

# 修复权限问题（必须）
RUN chmod 644 /opt/rabbitmq/plugins/rabbitmq_delayed_message_exchange-4.1.0.ez \
    && chown rabbitmq:rabbitmq /opt/rabbitmq/plugins/rabbitmq_delayed_message_exchange-4.1.0.ez

# 启用插件
RUN rabbitmq-plugins enable --offline rabbitmq_delayed_message_exchange

# 暴露端口
EXPOSE 5672 15672

CMD ["rabbitmq-server"]

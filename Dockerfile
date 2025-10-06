FROM rabbitmq:4.1.4-management

# 下载延迟消息插件
ADD https://github.com/rabbitmq/rabbitmq-delayed-message-exchange/releases/download/v4.1.0/rabbitmq_delayed_message_exchange-4.1.0.ez /plugins/

# 启用插件
RUN rabbitmq-plugins enable --offline rabbitmq_delayed_message_exchange

# 暴露端口
EXPOSE 5672 15672

CMD ["rabbitmq-server"]

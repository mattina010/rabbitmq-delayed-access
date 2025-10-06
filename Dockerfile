FROM rabbitmq:4.1.4-management

# 安装延迟消息插件
RUN rabbitmq-plugins enable --offline rabbitmq_delayed_message_exchange

# 暴露管理端口和 AMQP 端口
EXPOSE 5672 15672

# 启动 RabbitMQ 服务
CMD ["rabbitmq-server"]

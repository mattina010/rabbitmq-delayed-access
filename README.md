# 🚀 RabbitMQ with Delayed Message Plugin (for Railway)

This repository contains a custom Docker setup for RabbitMQ 4.1.4
with the **Delayed Message Exchange** plugin preinstalled and remote access enabled for `guest`.

## 🧩 Plugin Info

- Plugin: `rabbitmq_delayed_message_exchange`
- Version: `4.1.0`
- RabbitMQ: `4.1.4`
- Management UI: `http://localhost:15672`
- Default credentials: `guest / guest` (remote access enabled)

## 🛠 How to Deploy on Railway

1. Fork this repo or push it to your own GitHub.
2. Go to [Railway](https://railway.app).
3. Create a new service → **GitHub Repo** → select this repository.
4. Railway automatically builds and deploys it using the `Dockerfile`.
5. Wait until you see logs showing:

   ```
   Enabling plugins on node rabbit@...
   The following plugins have been enabled:
     rabbitmq_delayed_message_exchange
   ```

6. Access the management dashboard → **Exchanges** → create an exchange of type `x-delayed-message`.

## ✅ Test Delay Exchange

Run this in your application or `rabbitmqadmin`:

```bash
# Example: send a delayed message
rabbitmqadmin publish exchange=delayed_exchange routing_key=test payload="hello world"   properties='{"headers":{"x-delay":5000}}'
```

This message will be delivered after 5 seconds.

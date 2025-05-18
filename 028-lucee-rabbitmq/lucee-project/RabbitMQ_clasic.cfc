component {

  property name="connectionFactory";
  property name="connection";
  property name="channel";

    function init() {
        var cf = createObject("java", "com.rabbitmq.client.ConnectionFactory").init();
        cf.setHost("localhost");
        cf.setUsername("guest");
        cf.setPassword("guest");

        variables.connectionFactory = cf;
        variables.connection = cf.newConnection();
        variables.channel = variables.connection.createChannel();
        return this;
    }

    function sendMessage(queueName, message) {
        variables.channel.queueDeclare(queueName, false, false, false, javacast("null", ""));
        variables.channel.basicPublish("", queueName, javacast("null", ""), message.getBytes("UTF-8"));
        writeOutput("Message sent to queue: " & queueName);
    }

    function receiveMessage(queueName) {
        variables.channel.queueDeclare(queueName, false, false, false, javacast("null", ""));

        // Get the next message from the queue (if any)
        var response = variables.channel.basicGet(queueName, true);

        if (isNull(response)) {
            return "No message available.";
        } else {
            var body = response.getBody();
            return createObject("java", "java.lang.String").init(body, "UTF-8");
        }
    }



    function close() {
        if (isDefined("variables.channel")) variables.channel.close();
        if (isDefined("variables.connection")) variables.connection.close();
    }

}

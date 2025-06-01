component {

    property name="connectionFactory";
    property name="connection";
    property name="channel";

    function init() {
        var cf = createObject('java', 'com.rabbitmq.client.ConnectionFactory').init();
        cf.setHost('rabbitmq');
        cf.setUsername('guest');
        cf.setPassword('guest');

        variables.connectionFactory = cf;
        variables.connection = cf.newConnection();
        variables.channel = variables.connection.createChannel();
        return this;
    }

    // Declare quorum queue
    function declareQuorumQueue(queueName) {
        var HashMap = createObject('java', 'java.util.HashMap');
        var args = HashMap.init();
        args.put('x-queue-type', 'quorum');

        variables.channel.queueDeclare(
            queueName,
            true, // durable
            false,
            false,
            args
        );
    }

    // Send message (JSON string)
    function sendMessage(queueName, message) {
        declareQuorumQueue(queueName);
        variables.channel.basicPublish(
            '',
            queueName,
            javacast('null', ''),
            message.getBytes('UTF-8')
        );
        return message;
    }

    // Receive message (sync, JSON)
    function receiveMessage(queueName) {
        declareQuorumQueue(queueName);

        var response = variables.channel.basicGet(queueName, true);

        if (isNull(response)) {
            return 'No message available.';
        } else {
            var body = response.getBody();
            return createObject('java', 'java.lang.String').init(body, 'UTF-8');
        }
    }

    function close() {
        if (isDefined('variables.channel')) variables.channel.close();
        if (isDefined('variables.connection')) variables.connection.close();
    }

}

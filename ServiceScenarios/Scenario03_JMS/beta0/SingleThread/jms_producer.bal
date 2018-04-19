import ballerina/jms;
import ballerina/io;
import ballerina/runtime;

// Initialize a JMS connection with the provider
jms:Connection jmsConnection = new ({
        initialContextFactory: "wso2mbInitialContextFactory",
        providerUrl: "amqp://admin:admin@carbon/carbon?brokerlist='tcp://192.168.32.7:5672'"
    });

// Initialize a JMS session on top of the created connection
jms:Session jmsSession = new (jmsConnection, {
        acknowledgementMode: "AUTO_ACKNOWLEDGE"
    });

endpoint jms:QueueSender queueSender {
    session: jmsSession,
    queueName: "MyQueue"
};

function main (string[] args) {
	int i = 0;
	while (i < 720000000000) {
    // Create a Text message.
	runtime:sleepCurrentWorker(1);
    jms:Message m = check jmsSession.createTextMessage("Test Text");
    // Send the Ballerina message to the JMS provider.
    var _ = queueSender -> send(m);
	i = i +1;
}
  //  io:println("Message successfully sent by QueueSender");
}

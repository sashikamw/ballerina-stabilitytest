import ballerina/jms;
import ballerina/log;
import ballerina/runtime;

// Create a queue sender.
endpoint jms:SimpleQueueSender queueSender {
    initialContextFactory: "wso2mbInitialContextFactory",
    providerUrl: "amqp://admin:admin@carbon/carbon?brokerlist='tcp://192.168.32.7:5672'",
    acknowledgementMode: "AUTO_ACKNOWLEDGE",
    queueName: "MyQueue"
};


function main (string[] args) {
 	worker w1{
		int i = 0;
		while (i < 72000000000) {
			    runtime:sleepCurrentWorker(1);
			    jms:Message m = check queueSender.createTextMessage("Test Text One");
			    var _ = queueSender -> send(m);
			i = i +1;
		}
	}
	worker w2{
		int i = 0;
		while (i < 72000000000) {
			    runtime:sleepCurrentWorker(1);
			    jms:Message m = check queueSender.createTextMessage("Test Text Two");
			    var _ = queueSender -> send(m);
			i = i +1;
		}
	}
	worker w3{
		int i = 0;
		while (i < 72000000000) {
			    runtime:sleepCurrentWorker(1);
			    jms:Message m = check queueSender.createTextMessage("Test Text three");
			    var _ = queueSender -> send(m);
			i = i +1;
		}
	}
	worker w4{
		int i = 0;
		while (i < 72000000000) {
     			    runtime:sleepCurrentWorker(1);
			    jms:Message m = check queueSender.createTextMessage("Test Text Four");
			    var _ = queueSender -> send(m);
			i = i +1;
		}
	}
	worker w5{
		int i = 0;
		while (i < 72000000000) {
                            runtime:sleepCurrentWorker(1);
			    jms:Message m = check queueSender.createTextMessage("Test Text Five");
			    var _ = queueSender -> send(m);
			i = i +1;
		}
	}
}

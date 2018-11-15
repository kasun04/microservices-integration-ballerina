

import ballerina/log;
import wso2/kafka;
import ballerina/internal;

@final
public string CHECKOUT_EVENTS_TOPIC = "checkout-events";

endpoint kafka:SimpleConsumer kafkaConsumer {
    bootstrapServers: "localhost:9092, localhost:9093",
    groupId: "shpping_service",
    topics: [CHECKOUT_EVENTS_TOPIC],
    pollingInterval:1000
};

service<kafka:Consumer> ShippingService bind kafkaConsumer {
    onMessage(kafka:ConsumerAction consumerAction, kafka:ConsumerRecord[] records) {
        foreach entry in records {
            byte[] serializedMsg = entry.value;
            string msg = internal:byteArrayToString(serializedMsg, "UTF-8");
            log:printInfo("Topic: " + entry.topic + "; Received Message: " + msg);
            // Business Logic 
        }
    }
}
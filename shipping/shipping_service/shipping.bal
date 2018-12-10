

import ballerina/log;
import wso2/kafka;
import ballerina/internal;

public string CHECKOUT_EVENTS_TOPIC = "checkout-events";


kafka:ConsumerConfig consumerConfig = {
    bootstrapServers: "localhost:9092, localhost:9093",
    // Consumer group ID
    groupId: "shpping_service",
    // Listen from topic 'product-price'
    topics: [CHECKOUT_EVENTS_TOPIC],
    // Poll every 1 second
    pollingInterval: 1000
};

listener kafka:SimpleConsumer kafkaConsumer = new(consumerConfig);


service ShippingService on kafkaConsumer {
    resource function onMessage(kafka:SimpleConsumer simpleConsumer, kafka:ConsumerRecord[] records) {
        foreach var entry in records {
            byte[] serializedMsg = entry.value;
            string msg = internal:byteArrayToString(serializedMsg, "UTF-8");
            log:printInfo("Topic: " + entry.topic + "; Received Message: " + msg);
            // Business Logic 
        }
    }
}
import ballerina/log;
import wso2/kafka;
import ballerina/internal;
import ballerina/io;

// @final
public string CHECKOUT_EVENTS_TOPIC = "checkout-events";

// @final
public string FILE_DESTINATION = "./files/orders.csv";

// Kafka consumer listener configurations
kafka:ConsumerConfig consumerConfig = {
    bootstrapServers: "localhost:9092, localhost:9093",
    // Consumer group ID
    groupId: "inventorySystem",
    // Listen from topic 'product-price'
    topics: [CHECKOUT_EVENTS_TOPIC],
    // Poll every 1 second
    pollingInterval: 1000
};


listener kafka:SimpleConsumer kafkaConsumer = new(consumerConfig);

service OrderProcessingService on kafkaConsumer {
    resource function onMessage(kafka:SimpleConsumer simpleConsumer, kafka:ConsumerRecord[] records) {
        foreach var entry in records {
            byte[] serializedMsg = entry.value;
            string msg = internal:byteArrayToString(serializedMsg, "UTF-8");
            io:StringReader sr = new(msg);
            var msgJ = sr.readJson(); 

            if (msgJ is error) {

            } else {
                log:printInfo("Topic: " + entry.topic + "; Received Message: " + msg);
                // Writing a CSV to File system. 
                io:WritableCSVChannel wCsvChannel = io:openWritableCsvFile(FILE_DESTINATION);
                string [] fileRec = [ msgJ.productId.toString(), 
                                        msgJ.quantity.toString(), 
                                        msgJ.cardNo.toString(), 
                                        msgJ.customerId.toString() ]; 
                var returnedVal = wCsvChannel.write(fileRec);
                if (returnedVal is error) {
                    log:printError("Error while writing to CSV file.", err = returnedVal); 
                } else {
                    io:println("Record was successfully written to target file");
                }
                
                closeWritableCSVChannel(wCsvChannel);
            }
        }
    }
}

// function writeDataToCSVChannel(io:WritableCSVChannel csvChannel, string[]... data) {
//     foreach var rec in data {
//         var returnedVal = csvChannel.write(rec);
//         if (returnedVal is error ) {
//             log:printError("Error while writing to CSV file.", err = returnedVal); 
//         } else {
//             io:println("Record was successfully written to target file");
//         } 
//     }
// }

function closeWritableCSVChannel(io:WritableCSVChannel csvChannel) {

    var result = csvChannel.close(); 
    if (result is error) {
        log:printError("Error occured while closing the channel: ",
                err = result);
    } else {
        io:println("CSV channel closed successfully.");
    }
}
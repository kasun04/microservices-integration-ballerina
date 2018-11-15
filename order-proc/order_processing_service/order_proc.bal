import ballerina/log;
import wso2/kafka;
import ballerina/internal;
import ballerina/io;

@final
public string CHECKOUT_EVENTS_TOPIC = "checkout-events";

@final
public string FILE_DESTINATION = "./files/orders.csv";

endpoint kafka:SimpleConsumer kafkaConsumer {
    bootstrapServers: "localhost:9092, localhost:9093",
    groupId: "order_proc",
    topics: [CHECKOUT_EVENTS_TOPIC],
    pollingInterval:1000
};

service<kafka:Consumer> OrderProcessingService bind kafkaConsumer {
    onMessage(kafka:ConsumerAction consumerAction, kafka:ConsumerRecord[] records) {
        foreach entry in records {
            byte[] serializedMsg = entry.value;
            string msg = internal:byteArrayToString(serializedMsg, "UTF-8");
            io:StringReader sr = new(msg);
            json msgJ = check sr.readJson(); 

            log:printInfo("Topic: " + entry.topic + "; Received Message: " + msg);

            // Writing a CSV to File system. 
            io:WritableCSVChannel wCsvChannel = io:openWritableCsvFile(FILE_DESTINATION);
            string [] fileRec = [ msgJ.productId.toString(), 
                                    msgJ.quantity.toString(), 
                                    msgJ.cardNo.toString(), 
                                    msgJ.customerId.toString() ]; 
            var returnedVal = wCsvChannel.write(fileRec);
            match returnedVal {
                error e => io:println(e.message);
                () => io:println("Record was successfully written to target file");
            }
            closeWritableCSVChannel(wCsvChannel);
        }
    }
}

function writeDataToCSVChannel(io:WritableCSVChannel csvChannel, string[]... data) {
    foreach rec in data {
        var returnedVal = csvChannel.write(rec);
        match returnedVal {
            error e => io:println(e.message);
            () => io:println("Record was successfully written to target file");
        }
    }
}

function closeWritableCSVChannel(io:WritableCSVChannel csvChannel) {
    match csvChannel.close() {
        error channelCloseError => {
            log:printError("Error occured while closing the channel: ",
                err = channelCloseError);
        }
        () => io:println("CSV channel closed successfully.");
    }
}
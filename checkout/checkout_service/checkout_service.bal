import ballerina/http;
import wso2/kafka;


// @final
public string CHECKOUT_EVENTS_TOPIC = "checkout-events";

kafka:ProducerConfig producerConfigs = {
    bootstrapServers: "localhost:9092",
    clientID: "basic-producer",
    acks: "all",
    noRetries: 3
};

kafka:SimpleProducer kafkaProducer = new(producerConfigs);

listener http:Listener httpListener = new(9090);

@http:ServiceConfig {basePath:"/checkout"}
service CheckoutService on httpListener {

    @http:ResourceConfig { 
        path: "/", 
        methods:["POST"], 
        consumes:["application/json"],
        produces:["application/json"] 
    }
    resource function updatePrice (http:Caller caller, http:Request request) {
        http:Response response = new;
       
        json|error checkoutMsg = request.getJsonPayload(); 
        if (checkoutMsg is error) {
            // ToDo : Handle error condition 

        } else {
            byte[] serializedCheckoutReq = checkoutMsg.toString().toByteArray("UTF-8");
            var sendResult = kafkaProducer->send(serializedCheckoutReq, CHECKOUT_EVENTS_TOPIC, partition = 0);
            if (sendResult is error) {
                response.statusCode = 500;
                response.setJsonPayload({ "Message": "Kafka producer failed to send data" });
                _ = caller->respond(response);    
            }
            response.statusCode = 202; 
            response.setJsonPayload({"Status":"Success"});
            _ = caller->respond(response);
        }

        
    }
}

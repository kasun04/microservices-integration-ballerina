import ballerina/http;
import wso2/kafka;


@final
public string CHECKOUT_EVENTS_TOPIC = "checkout-events";

endpoint kafka:SimpleProducer kafkaProducer {
    bootstrapServers: "localhost:9092",
    clientID:"basic-producer",
    acks:"all",
    noRetries:3
};

endpoint http:Listener listener {
    port:9090
};

@http:ServiceConfig {basePath:"/checkout"}
service<http:Service> CheckoutService bind listener {

    @http:ResourceConfig { 
        path: "/", 
        methods:["POST"], 
        consumes:["application/json"],
        produces:["application/json"] 
    }
    updatePrice (endpoint client, http:Request request) {
        http:Response response;
       
        json checkoutMsg = check request.getJsonPayload(); 
        byte[] serializedCheckoutReq = checkoutMsg.toString().toByteArray("UTF-8");

        kafkaProducer->send(serializedCheckoutReq, CHECKOUT_EVENTS_TOPIC, partition = 0);

        response.statusCode = 202; 
        response.setJsonPayload({"Status":"Success"});
        _ = client->respond(response);
    }
}

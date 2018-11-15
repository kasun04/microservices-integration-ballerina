import ballerina/io;
import ballerina/grpc;

public function main (string... args) {
     endpoint ProdInfoServiceClient ep {
        url:"http://localhost:9090"
     };

    endpoint ProdInfoServiceBlockingClient blockingEp {
        url:"http://localhost:9090"
    };

}

service<grpc:Service> ProdInfoServiceMessageListener {

    onMessage (string message) {
        io:println("Response received from server: " + message);
    }

    onError (error err) {
        if (err != ()) {
            io:println("Error reported from server: " + err.message);
        }
    }

    onComplete () {
        io:println("Server Complete Sending Responses.");
    }
}

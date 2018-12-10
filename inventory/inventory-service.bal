import ballerina/grpc;
import ballerina/io;


listener grpc:Listener gRPClistener = new (6061);

// Type definition for an order.
type Item record {
    string id;
    int quantity;
};

@grpc:ServiceConfig
service InventoryService on gRPClistener {
    resource function getItem(grpc:Caller caller, string id) {
        io:println("==== Inventory infomation found for Product ID - " + id);
        // Sample inventory data 
        Item inventoryItem = {id:"100105", quantity:124};
        // Send response to the caller.
        _ = caller->send(inventoryItem);
        _ = caller->complete();
    }
}


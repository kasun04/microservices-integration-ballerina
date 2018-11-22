import ballerina/grpc;
import ballerina/io;
import ballerina/mysql;
import ballerina/sql;
import ballerina/config;


endpoint grpc:Listener listener {
    host:"localhost",
    port:6060
};

endpoint mysql:Client productInfoDB {
    host: config:getAsString("DATABASE_HOST", default = "localhost"),
    port: config:getAsInt("DATABASE_PORT", default = 3306),
    name: config:getAsString("DATABASE_NAME", default = "PRODUCT_INFO"),
    username: config:getAsString("DATABASE_USERNAME", default = "root"),
    password: config:getAsString("DATABASE_PASSWORD", default = "admin123"),
    dbOptions: { useSSL: false }
};

@grpc:ServiceConfig
service ProdInfoService bind listener {

    getProductByID(endpoint caller, string value) {
        // Implementation goes here.

        string sqlString = "SELECT * FROM PRODUCT WHERE ID = ?";
        table<ProductInfo> productTable = check productInfoDB->select(sqlString, ProductInfo, value);
        ProductInfo p =  check <ProductInfo>productTable.getNext();
        if (p != null) {
            io:println("==== Requested product - " + p.name + " found!");
        }
        
        _ = caller->send(p, headers = ()); 
        _ = caller->complete(); 

        // You should return a ProductInfo
    }
    addProduct(endpoint caller, ProductInfo value) {
        // Implementation goes here.

        // You should return a boolean
    }
}


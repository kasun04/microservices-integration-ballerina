import ballerina/grpc;
import ballerina/sql;
import ballerina/mysql;
import ballerina/config;
import ballerina/io; 

listener grpc:Listener ep = new (6060);


mysql:Client productInfoDB = new({
        host: config:getAsString("DATABASE_HOST", default = "localhost"),
        port: config:getAsInt("DATABASE_PORT", default = 3306),
        name: config:getAsString("DATABASE_NAME", default = "PRODUCT_INFO"),
        username: config:getAsString("DATABASE_USERNAME", default = "root"),
        password: config:getAsString("DATABASE_PASSWORD", default = "admin123"),
        dbOptions: { useSSL: false }
});


service ProdInfoService on ep {

    resource function getProductByID(grpc:Caller caller, string value) {
        // Implementation

        string sqlString = "SELECT * FROM PRODUCT WHERE ID = ?";
        
        var dt = productInfoDB->select(sqlString, ProductInfo, value);
        if (dt is table<ProductInfo>) {
            while(dt.hasNext()) {
                var e = ProductInfo.convert(dt.getNext());
                if (e is ProductInfo) {   
                    io:println(e.name);                 
                    _ = caller->send(e, headers = ()); 
                    _ = caller->complete(); 
                }

            }
        } else if (dt is error) {
            panic dt;
        }


        // table<ProductInfo> productTable = check productInfoDB->select(sqlString, ProductInfo, value);
        // ProductInfo p =  check <ProductInfo>productTable.getNext();


        // if (p != null) {
        //     io:println("==== Requested product - " + p.name + " found!");
        // }
        
        // _ = caller->send(p, headers = ()); 
        // _ = caller->complete(); 

        // You should return a ProductInfo
    }
    resource function addProduct(grpc:Caller caller, ProductInfo value) {
        // Implementation goes here.

        // You should return a boolean
    }
}


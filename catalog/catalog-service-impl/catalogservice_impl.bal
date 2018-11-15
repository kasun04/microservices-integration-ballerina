
import ballerina/io;
import ballerina/grpc;

endpoint ProdInfoServiceBlockingClient grpcProdInfo {
    url:"http://localhost:6060"
};


endpoint InventoryServiceBlockingClient grpcInventory {
    url:"http://localhost:6061"
};

public function listProducts (http:Request _listProductsReq) returns http:Response {
    // stub code - fill as necessary
    http:Response _listProductsRes = new;
    string _listProductsPayload = "Sample listProducts Response";
    _listProductsRes.setTextPayload(_listProductsPayload);
	return _listProductsRes;
}

public function createProducts (http:Request _createProductsReq) returns http:Response {
    // stub code - fill as necessary
    http:Response _createProductsRes = new;
    string _createProductsPayload = "Sample createProducts Response";
    _createProductsRes.setTextPayload(_createProductsPayload);

	return _createProductsRes;
}

public function showProductById (http:Request _showProductByIdReq, string productId) returns http:Response {
    // Implementation 
    http:Response _showProductByIdRes = new;    

    Product product; 
    product.id = check <int>productId; 

    // Invoking ProductInfo service via gRPC 
    var (prodx, headerx) = check grpcProdInfo->getProductByID(productId, headers = ()); 
    product.id = check <int> prodx.id; 
    product.name = prodx.name; 
    product.price = prodx.price; 
    product.description = prodx.description; 

    // Invoking Inventory service via gRPC 
    var (invItem, invHeaders) = check grpcInventory->getItem(productId, headers = ()); 
    product.quantity = invItem.quantity; 

    // Generate the final JSON response 
    json product_j = check <json>product; 
    _showProductByIdRes.setJsonPayload(product_j, contentType = "application/json"); 
	return _showProductByIdRes;
}




ProdInfoServiceBlockingClient grpcProdInfo = new("http://localhost:6060");
InventoryServiceBlockingClient grpcInventory = new("http://localhost:6061");

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

    Product product = {id:0, name:"", description:"", price:0.0, quantity:0}; 


    // Invoking ProductInfo service via gRPC 
    var (prodx, headerx) = check grpcProdInfo->getProductByID(productId, headers = ()); 
    // ToDo 
    // product.id =  check int.convert(productId); 
    product.id = 100105; 
    product.name = prodx.name; 
    product.price = prodx.price; 
    product.description = prodx.description; 
    io:println("==== ProdInfo Service Invocation successful! ====");

    // Invoking Inventory service via gRPC 
    
    var (invItem, invHeaders) = check grpcInventory->getItem(productId, headers = ()); 
    product.quantity = invItem.quantity; 
    io:println("==== Inventory Service Invocation successful! ====");

    // Generate the final JSON response 
    // ToDo
    var product_j =   json.convert(product); 
    if (product_j is json) {
        _showProductByIdRes.setJsonPayload(product_j, contentType = "application/json"); 
    }

    // json product_j = {sd:"foo"}; 
    // ToDo 
    // _showProductByIdRes.setJsonPayload(product_j, contentType = "application/json"); 
	return _showProductByIdRes;

}


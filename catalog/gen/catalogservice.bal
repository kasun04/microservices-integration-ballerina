import ballerina/http;
import ballerina/log;
import ballerina/mime;
import ballerina/swagger;

listener http:Listener ep0 = new(9090, config = {host: "localhost"});

@swagger:ServiceInfo {
    title: "CatalogService",
    serviceVersion: "1.0.0",
    license: {name: "MIT", url: ""}
}
@http:ServiceConfig {
    basePath: "/catalog"
}
service CatalogService on ep0 {

    @swagger:ResourceInfo {
        summary: "List all Products",
        tags: ["Products"],
        parameters: [
            {
                name: "limit",
                inInfo: "query",
                paramType: "int",
                description: "How many items to return at one time (max 100)",
                allowEmptyValue: ""
            }
        ]
    }
    @http:ResourceConfig {
        methods:["GET"],
        path:"/products"
    }
    resource function listProducts (http:Caller outboundEp, http:Request _listProductsReq) {
        http:Response _listProductsRes = listProducts(_listProductsReq);
        _ = outboundEp->respond(_listProductsRes);
    }

    @swagger:ResourceInfo {
        summary: "Create a Product",
        tags: ["Products"]
    }
    @http:ResourceConfig {
        methods:["POST"],
        path:"/products"
    }
    resource function createProducts (http:Caller outboundEp, http:Request _createProductsReq) {
        http:Response _createProductsRes = createProducts(_createProductsReq);
        _ = outboundEp->respond(_createProductsRes);
    }

    @swagger:ResourceInfo {
        summary: "Info for a specific Product",
        tags: ["Products"],
        parameters: [
            {
                name: "productId",
                inInfo: "path",
                paramType: "string",
                description: "The id of the Product to retrieve",
                required: true,
                allowEmptyValue: ""
            }
        ]
    }
    @http:ResourceConfig {
        methods:["GET"],
        path:"/products/{productId}"
    }
    resource function showProductById (http:Caller outboundEp, http:Request _showProductByIdReq, string productId) {
        http:Response _showProductByIdRes = showProductById(_showProductByIdReq, productId);
        _ = outboundEp->respond(_showProductByIdRes);
    }

}

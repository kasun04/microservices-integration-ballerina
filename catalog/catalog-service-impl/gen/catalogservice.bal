import ballerina/http;
import ballerina/log;
import ballerina/mime;
import ballerina/swagger;

endpoint http:Listener ep0 { 
    host: "localhost",
    port: 9090
};

@swagger:ServiceInfo { 
    title: "CatalogService",
    serviceVersion: "1.0.0",
    license: {name: "MIT", url: ""}
}
@http:ServiceConfig {
    basePath: "/catalog"
}
service CatalogService bind ep0 {

    @swagger:ResourceInfo {
        summary: "List all Products",
        tags: ["Products"],
        parameters: [
            {
                name: "limit",
                inInfo: "query",
                description: "How many items to return at one time (max 100)",  
                allowEmptyValue: ""
            }
        ]
    }
    @http:ResourceConfig { 
        methods:["GET"],
        path:"/products"
    }
    listProducts (endpoint outboundEp, http:Request _listProductsReq) { 
        http:Response _listProductsRes = listProducts(_listProductsReq);
        outboundEp->respond(_listProductsRes) but { error e => log:printError("Error while responding", err = e) };
    }

    @swagger:ResourceInfo {
        summary: "Create a Product",
        tags: ["Products"]
    }
    @http:ResourceConfig { 
        methods:["POST"],
        path:"/products"
    }
    createProducts (endpoint outboundEp, http:Request _createProductsReq) { 
        http:Response _createProductsRes = createProducts(_createProductsReq);
        outboundEp->respond(_createProductsRes) but { error e => log:printError("Error while responding", err = e) };
    }

    @swagger:ResourceInfo {
        summary: "Info for a specific Product",
        tags: ["Products"],
        parameters: [
            {
                name: "productId",
                inInfo: "path",
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
    showProductById (endpoint outboundEp, http:Request _showProductByIdReq, string productId) { 
        http:Response _showProductByIdRes = showProductById(_showProductByIdReq, untaint productId);
        outboundEp->respond(_showProductByIdRes) but { error e => log:printError("Error while responding", err = e) };
    }

}

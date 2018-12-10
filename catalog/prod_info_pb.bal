import ballerina/grpc;
import ballerina/io;

public type ProdInfoServiceBlockingClient client object {
    private grpc:Client grpcClient = new;
    private grpc:ClientEndpointConfig config = {};
    private string url;

    function __init(string url, grpc:ClientEndpointConfig? config = ()) {
        self.config = config ?: {};
        self.url = url;
        // initialize client endpoint.
        grpc:Client c = new;
        c.init(self.url, self.config);
        error? result = c.initStub("blocking", ROOT_DESCRIPTOR_PROD, getDescriptorMapProd());
        if (result is error) {
            panic result;
        } else {
            self.grpcClient = c;
        }
    }


    remote function getProductByID(string req, grpc:Headers? headers = ()) returns ((ProductInfo, grpc:Headers)|error) {
        
        var payload = check self.grpcClient->blockingExecute("kasun.grpc.retail.product.ProdInfoService/getProductByID", req, headers = headers);
        grpc:Headers resHeaders = new;
        any result = ();
        (result, resHeaders) = payload;
        var value = ProductInfo.convert(result);
        if (value is ProductInfo) {
            return (value, resHeaders);
        } else {
            error err = error("{ballerina/grpc}INTERNAL", {"message": value.reason()});
            return err;
        }
    }

    remote function addProduct(ProductInfo req, grpc:Headers? headers = ()) returns ((boolean, grpc:Headers)|error) {
        
        var payload = check self.grpcClient->blockingExecute("kasun.grpc.retail.product.ProdInfoService/addProduct", req, headers = headers);
        grpc:Headers resHeaders = new;
        any result = ();
        (result, resHeaders) = payload;
        var value = boolean.convert(result);
        if (value is boolean) {
            return (value, resHeaders);
        } else {
            error err = error("{ballerina/grpc}INTERNAL", {"message": value.reason()});
            return err;
        }
    }

};

public type ProdInfoServiceClient client object {
    private grpc:Client grpcClient = new;
    private grpc:ClientEndpointConfig config = {};
    private string url;

    function __init(string url, grpc:ClientEndpointConfig? config = ()) {
        self.config = config ?: {};
        self.url = url;
        // initialize client endpoint.
        grpc:Client c = new;
        c.init(self.url, self.config);
        error? result = c.initStub("non-blocking", ROOT_DESCRIPTOR_PROD, getDescriptorMapProd());
        if (result is error) {
            panic result;
        } else {
            self.grpcClient = c;
        }
    }


    remote function getProductByID(string req, service msgListener, grpc:Headers? headers = ()) returns (error?) {
        
        return self.grpcClient->nonBlockingExecute("kasun.grpc.retail.product.ProdInfoService/getProductByID", req, msgListener, headers = headers);
    }

    remote function addProduct(ProductInfo req, service msgListener, grpc:Headers? headers = ()) returns (error?) {
        
        return self.grpcClient->nonBlockingExecute("kasun.grpc.retail.product.ProdInfoService/addProduct", req, msgListener, headers = headers);
    }

};

type ProductInfo record {
    string id;
    string name;
    string description;
    float price;
    
};



const string ROOT_DESCRIPTOR_PROD = "0A0F70726F645F696E666F2E70726F746F12196B6173756E2E677270632E72657461696C2E70726F647563741A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F22690A0B50726F64756374496E666F120E0A0269641801200128095202696412120A046E616D6518022001280952046E616D6512200A0B6465736372697074696F6E180320012809520B6465736372697074696F6E12140A0570726963651804200128025205707269636532BB010A0F50726F64496E666F5365727669636512560A0E67657450726F6475637442794944121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A262E6B6173756E2E677270632E72657461696C2E70726F647563742E50726F64756374496E666F12500A0A61646450726F6475637412262E6B6173756E2E677270632E72657461696C2E70726F647563742E50726F64756374496E666F1A1A2E676F6F676C652E70726F746F6275662E426F6F6C56616C7565620670726F746F33";
function getDescriptorMapProd() returns map<string> {
    return {
        "prod_info.proto":"0A0F70726F645F696E666F2E70726F746F12196B6173756E2E677270632E72657461696C2E70726F647563741A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F22690A0B50726F64756374496E666F120E0A0269641801200128095202696412120A046E616D6518022001280952046E616D6512200A0B6465736372697074696F6E180320012809520B6465736372697074696F6E12140A0570726963651804200128025205707269636532BB010A0F50726F64496E666F5365727669636512560A0E67657450726F6475637442794944121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A262E6B6173756E2E677270632E72657461696C2E70726F647563742E50726F64756374496E666F12500A0A61646450726F6475637412262E6B6173756E2E677270632E72657461696C2E70726F647563742E50726F64756374496E666F1A1A2E676F6F676C652E70726F746F6275662E426F6F6C56616C7565620670726F746F33",
        "google/protobuf/wrappers.proto":"0A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F120F676F6F676C652E70726F746F62756622230A0B446F75626C6556616C756512140A0576616C7565180120012801520576616C756522220A0A466C6F617456616C756512140A0576616C7565180120012802520576616C756522220A0A496E74363456616C756512140A0576616C7565180120012803520576616C756522230A0B55496E74363456616C756512140A0576616C7565180120012804520576616C756522220A0A496E74333256616C756512140A0576616C7565180120012805520576616C756522230A0B55496E74333256616C756512140A0576616C756518012001280D520576616C756522210A09426F6F6C56616C756512140A0576616C7565180120012808520576616C756522230A0B537472696E6756616C756512140A0576616C7565180120012809520576616C756522220A0A427974657356616C756512140A0576616C756518012001280C520576616C756542570A13636F6D2E676F6F676C652E70726F746F627566420D577261707065727350726F746F50015A057479706573F80101A20203475042AA021E476F6F676C652E50726F746F6275662E57656C6C4B6E6F776E5479706573620670726F746F33"
        
    };
}


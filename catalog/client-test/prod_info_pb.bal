import ballerina/grpc;
import ballerina/io;

public type ProdInfoServiceBlockingStub object {
    public grpc:Client clientEndpoint;
    public grpc:Stub stub;

    function initStub (grpc:Client ep) {
        grpc:Stub navStub = new;
        navStub.initStub(ep, "blocking", DESCRIPTOR_KEY, descriptorMap);
        self.stub = navStub;
    }
    
    function getProductByID (string req, grpc:Headers? headers = ()) returns ((ProductInfo, grpc:Headers)|error) {
        
        var unionResp = self.stub.blockingExecute("kasun.grpc.retail.product.ProdInfoService/getProductByID", req, headers = headers);
        match unionResp {
            error payloadError => {
                return payloadError;
            }
            (any, grpc:Headers) payload => {
                grpc:Headers resHeaders;
                any result;
                (result, resHeaders) = payload;
                return (check <ProductInfo>result, resHeaders);
            }
        }
    }
    
    function addProduct (ProductInfo req, grpc:Headers? headers = ()) returns ((boolean, grpc:Headers)|error) {
        
        var unionResp = self.stub.blockingExecute("kasun.grpc.retail.product.ProdInfoService/addProduct", req, headers = headers);
        match unionResp {
            error payloadError => {
                return payloadError;
            }
            (any, grpc:Headers) payload => {
                grpc:Headers resHeaders;
                any result;
                (result, resHeaders) = payload;
                return (check <boolean>result, resHeaders);
            }
        }
    }
    
};

public type ProdInfoServiceStub object {
    public grpc:Client clientEndpoint;
    public grpc:Stub stub;

    function initStub (grpc:Client ep) {
        grpc:Stub navStub = new;
        navStub.initStub(ep, "non-blocking", DESCRIPTOR_KEY, descriptorMap);
        self.stub = navStub;
    }
    
    function getProductByID (string req, typedesc listener, grpc:Headers? headers = ()) returns (error?) {
        
        return self.stub.nonBlockingExecute("kasun.grpc.retail.product.ProdInfoService/getProductByID", req, listener, headers = headers);
    }
    
    function addProduct (ProductInfo req, typedesc listener, grpc:Headers? headers = ()) returns (error?) {
        
        return self.stub.nonBlockingExecute("kasun.grpc.retail.product.ProdInfoService/addProduct", req, listener, headers = headers);
    }
    
};


public type ProdInfoServiceBlockingClient object {
    public grpc:Client client;
    public ProdInfoServiceBlockingStub stub;

    public function init (grpc:ClientEndpointConfig config) {
        // initialize client endpoint.
        grpc:Client c = new;
        c.init(config);
        self.client = c;
        // initialize service stub.
        ProdInfoServiceBlockingStub s = new;
        s.initStub(c);
        self.stub = s;
    }

    public function getCallerActions () returns ProdInfoServiceBlockingStub {
        return self.stub;
    }
};

public type ProdInfoServiceClient object {
    public grpc:Client client;
    public ProdInfoServiceStub stub;

    public function init (grpc:ClientEndpointConfig config) {
        // initialize client endpoint.
        grpc:Client c = new;
        c.init(config);
        self.client = c;
        // initialize service stub.
        ProdInfoServiceStub s = new;
        s.initStub(c);
        self.stub = s;
    }

    public function getCallerActions () returns ProdInfoServiceStub {
        return self.stub;
    }
};


type ProductInfo record {
    string id;
    string name;
    string description;
    float price;
    
};


@final string DESCRIPTOR_KEY = "kasun.grpc.retail.product.prod_info.proto";
map descriptorMap = {
"kasun.grpc.retail.product.prod_info.proto":"0A0F70726F645F696E666F2E70726F746F12196B6173756E2E677270632E72657461696C2E70726F647563741A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F22690A0B50726F64756374496E666F120E0A0269641801200128095202696412120A046E616D6518022001280952046E616D6512200A0B6465736372697074696F6E180320012809520B6465736372697074696F6E12140A0570726963651804200128025205707269636532BB010A0F50726F64496E666F5365727669636512560A0E67657450726F6475637442794944121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A262E6B6173756E2E677270632E72657461696C2E70726F647563742E50726F64756374496E666F12500A0A61646450726F6475637412262E6B6173756E2E677270632E72657461696C2E70726F647563742E50726F64756374496E666F1A1A2E676F6F676C652E70726F746F6275662E426F6F6C56616C7565620670726F746F33",
"google.protobuf.wrappers.proto":"0A0E77726170706572732E70726F746F120F676F6F676C652E70726F746F62756622230A0B446F75626C6556616C756512140A0576616C7565180120012801520576616C756522220A0A466C6F617456616C756512140A0576616C7565180120012802520576616C756522220A0A496E74363456616C756512140A0576616C7565180120012803520576616C756522230A0B55496E74363456616C756512140A0576616C7565180120012804520576616C756522220A0A496E74333256616C756512140A0576616C7565180120012805520576616C756522230A0B55496E74333256616C756512140A0576616C756518012001280D520576616C756522210A09426F6F6C56616C756512140A0576616C7565180120012808520576616C756522230A0B537472696E6756616C756512140A0576616C7565180120012809520576616C756522220A0A427974657356616C756512140A0576616C756518012001280C520576616C756542570A13636F6D2E676F6F676C652E70726F746F627566420D577261707065727350726F746F50015A057479706573F80101A20203475042AA021E476F6F676C652E50726F746F6275662E57656C6C4B6E6F776E5479706573620670726F746F33"

};

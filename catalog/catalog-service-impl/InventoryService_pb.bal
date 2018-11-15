import ballerina/grpc;
import ballerina/io;

public type InventoryServiceBlockingStub object {
    public grpc:Client clientEndpoint;
    public grpc:Stub stub;

    function initStub (grpc:Client ep) {
        grpc:Stub navStub = new;
        navStub.initStub(ep, "blocking", INV_DESCRIPTOR_KEY, invDescriptorMap);
        self.stub = navStub;
    }
    
    function getItem (string req, grpc:Headers? headers = ()) returns ((Item, grpc:Headers)|error) {
        
        var unionResp = self.stub.blockingExecute("inventory_cf.InventoryService/getItem", req, headers = headers);
        match unionResp {
            error payloadError => {
                return payloadError;
            }
            (any, grpc:Headers) payload => {
                grpc:Headers resHeaders;
                any result;
                (result, resHeaders) = payload;
                return (check <Item>result, resHeaders);
            }
        }
    }
    
};

public type InventoryServiceStub object {
    public grpc:Client clientEndpoint;
    public grpc:Stub stub;

    function initStub (grpc:Client ep) {
        grpc:Stub navStub = new;
        navStub.initStub(ep, "non-blocking", INV_DESCRIPTOR_KEY, invDescriptorMap);
        self.stub = navStub;
    }
    
    function getItem (string req, typedesc listener, grpc:Headers? headers = ()) returns (error?) {
        
        return self.stub.nonBlockingExecute("inventory_cf.InventoryService/getItem", req, listener, headers = headers);
    }
    
};


public type InventoryServiceBlockingClient object {
    public grpc:Client client;
    public InventoryServiceBlockingStub stub;

    public function init (grpc:ClientEndpointConfig config) {
        // initialize client endpoint.
        grpc:Client c = new;
        c.init(config);
        self.client = c;
        // initialize service stub.
        InventoryServiceBlockingStub s = new;
        s.initStub(c);
        self.stub = s;
    }

    public function getCallerActions () returns InventoryServiceBlockingStub {
        return self.stub;
    }
};

public type InventoryServiceClient object {
    public grpc:Client client;
    public InventoryServiceStub stub;

    public function init (grpc:ClientEndpointConfig config) {
        // initialize client endpoint.
        grpc:Client c = new;
        c.init(config);
        self.client = c;
        // initialize service stub.
        InventoryServiceStub s = new;
        s.initStub(c);
        self.stub = s;
    }

    public function getCallerActions () returns InventoryServiceStub {
        return self.stub;
    }
};


type Item record {
    string id;
    int quantity;
    
};


@final string INV_DESCRIPTOR_KEY = "inventory_cf.InventoryService.proto";
map invDescriptorMap = {
"inventory_cf.InventoryService.proto":"0A16496E76656E746F7279536572766963652E70726F746F120C696E76656E746F72795F63661A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F22320A044974656D120E0A02696418012001280952026964121A0A087175616E7469747918022001280352087175616E74697479324F0A10496E76656E746F727953657276696365123B0A076765744974656D121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A122E696E76656E746F72795F63662E4974656D620670726F746F33",
"google.protobuf.wrappers.proto":"0A0E77726170706572732E70726F746F120F676F6F676C652E70726F746F62756622230A0B446F75626C6556616C756512140A0576616C7565180120012801520576616C756522220A0A466C6F617456616C756512140A0576616C7565180120012802520576616C756522220A0A496E74363456616C756512140A0576616C7565180120012803520576616C756522230A0B55496E74363456616C756512140A0576616C7565180120012804520576616C756522220A0A496E74333256616C756512140A0576616C7565180120012805520576616C756522230A0B55496E74333256616C756512140A0576616C756518012001280D520576616C756522210A09426F6F6C56616C756512140A0576616C7565180120012808520576616C756522230A0B537472696E6756616C756512140A0576616C7565180120012809520576616C756522220A0A427974657356616C756512140A0576616C756518012001280C520576616C756542570A13636F6D2E676F6F676C652E70726F746F627566420D577261707065727350726F746F50015A057479706573F80101A20203475042AA021E476F6F676C652E50726F746F6275662E57656C6C4B6E6F776E5479706573620670726F746F33"

};

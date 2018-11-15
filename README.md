# Microservices Integration with Ballerina 


## Active Composition 
### Catalog Service 
```

$ ballerina swagger mock ../service-defn/catalog_oapi.yaml -m ./catalog-service-impl
```

### Inventory Service 


- Generating service skeleton 
``` 
ballerina grpc --input ./service-defn/inventory.proto --output inventory/service-impl --mode service

```

- Generating client stub 
``` 
ballerina grpc --input ./service-defn/inventory.proto --output bal-client --mode client 
```


### Electronics Dept Service 

- Generating service skeleton 

```
ballerina grpc --input ./service-defn/electronics.proto --output ./electronics/service-impl --mode service 

```

- Generating client stub 

```
ballerina grpc --input ./service-defn/electronics.proto --output ./catalog/catalog-service-impl/electronics-client --mode client 

```


## Reactice Composition/Choreography 

- Invoke Checkout Service 
```

curl -v -X POST -d    '{"productId":"100105", "quantity":5, "cardNo":"1234432123145", "customerId":"AAA11CC"}'    "http://localhost:9090/checkout" -H "Content-Type:application/json"


```





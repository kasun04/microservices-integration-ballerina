

public type Products record { 
    Product[] productList;
};

public type Product record { 
    int id;
    string name;
    string description;
    float price;
    int quantity;
};

public type Error record { 
    int code;
    string message;
};
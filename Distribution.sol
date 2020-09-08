pragma solidity >=0.4.22 <0.7.0;

contract Agriculture{
    address owner_address;
    address producer_address = 0x10C5D227f4240Ba1B168960C7561c2cd1DE1d671;
    address distributor_address = 0x0EeDCA37Dd9fCdb82922a279395E36b90e2a07b8;
    address wholeseller_address = 0x324a32E8378175F11Fba15605af24B226b19825C;
    address retailer_address = 0x5a2E8116e58884EcC159a403EE628f2634C2757f;
    
    
    
    // all the dates ensuring varifiability
    uint initiation_date;
    uint dist_start_date;
    uint wholesale_start_date;
    uint retail_start_date;
    
    string product_id;
    string product_name;
    
    //prices in different level of distribution
    uint producer_price;
    uint distributor_price;
    uint wholesell_price;
    uint retail_price;
    
    
    // traces of quantities sold in different levels of distribution
    
    uint producer_sold_quantity;
    uint distributor_sold_quantity;
    uint wholeseller_sold_quantity;
    uint retail_sold_quantity;
    
    enum CurrentTrace {Producer, Distributor, Wholesale, Retail}
    CurrentTrace public trace;
    
    
    //event
    event DistributionInitiate(address ad, string  masg);
    event DistributionStart(address ad, string masg);
    event WholesellerStart(address ad, string masg);
    event RetailSell(address ad, string masg);
    
    
    //modifiers
    
    modifier onlyOwner(){
        require(msg.sender == owner_address);
        _;
    }
    
    modifier onlyProuducer(){
        require(msg.sender == producer_address);
        _;
    }
    
    
    modifier onlyDistributor(){
        require(msg.sender == distributor_address);
        _;
    }
    
    modifier onlyWholeseller(){
        require(msg.sender == wholeseller_address);
        _;
    }
    
    // constructor and methods
    constructor() internal{
        owner_address = msg.sender;
    }
    
    
    function initiateDistribution(
        string memory name,
        string memory id,
        uint price,
        uint quant) internal onlyProuducer{
        
        trace = CurrentTrace.Producer;
        initiation_date = block.timestamp;
        product_name = name;
        product_id = id;
        producer_price = price;
        producer_sold_quantity = quant;
        
        emit DistributionInitiate(producer_address, "Product Ready for distribution");
        
    }
    
    function startDistribution(uint dist_quant, uint dist_price) internal onlyDistributor{
        
        dist_start_date = block.timestamp;
        distributor_price = dist_price;
        distributor_sold_quantity = dist_quant;
        
        trace = CurrentTrace.Distributor;
        emit DistributionStart(distributor_address, "Product distribution started");
    }
    
    function startWholesale(uint whole_price, uint whole_quant) internal onlyWholeseller{
        
        wholesale_start_date = block.timestamp;
        
        wholeseller_sold_quantity = whole_quant;
        wholesell_price = whole_price;
        trace = CurrentTrace.Wholesale;
        emit WholesellerStart(wholeseller_address, "Product is with wholeseller now"); 
    }
    
    function retailSell(uint ret_price, uint ret_quant)internal{
        
        retail_start_date = block.timestamp;
        retail_price = ret_price;
        retail_sold_quantity = ret_quant;
        
        emit RetailSell(retailer_address, "Retail product sold");
        trace = CurrentTrace.Retail;
    }
    
}
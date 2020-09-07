pragma solidity >=0.4.22 <0.7.0;

contract Agriculture{
    
    address owner;
    address warehouse;
    address seller;
    address farmer;
    
    string seedName;
    uint quantity;
    uint unitPrice;
    uint optimumTemp = 25;
    uint optimumHum = 70;
    uint storageDate;
    
    
    enum TempCondition {Optimum, Over, Under}
    TempCondition public tempCOn;
    
    enum HumCondition {Optimum, Over, Under}
    HumCondition public humCOn;
    
    enum IssueType{None, Temperature, Hummidity, DateOver}
    
    constructor() internal{
        owner = msg.sender;
        storageDate = block.timestamp;
    }
    
    modifier OnlyOwner(){
        require(msg.sender == owner);
        _;
    }
    
    modifier OnlyWarehouse(){
        require(msg.sender == warehouse);
        _;
    }
    
    modifier OnlySeller(){
        require(msg.sender == seller);
        _;
    }
    
    function addWarehouse(address ad) internal{
        warehouse = ad;
    }
    
    function addSeller(address ad) internal{
        seller = ad;
    }
    
    
    
    
}
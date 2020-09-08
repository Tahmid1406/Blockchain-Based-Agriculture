pragma solidity >=0.4.22 <0.7.0;

contract Storage{
    
    address owner_address;
    address storage_address = 0x071424020940883EAdBbe98C2b8E5876CF44E218;
    
    
    string seedName;
    string batch_id;
    uint quantity;
    uint unitPrice;
    uint optimumTemp;
    uint optimumHum;
    uint optimumLightExpo;
    uint storageDate;
    
    
    enum TempCondition {Optimum, Over, Under}
    TempCondition public tempCOn;
    
    enum HumCondition {Optimum, Over, Under}
    HumCondition public humCOn;
    
    enum LightExpoCondition {Optimum, Over, Under}
    LightExpoCondition public lightCOn;
    
    enum ViolationType{None, Temperature, Hummidity, LightExposure}
    ViolationType public violationType;
    
    constructor() internal{
        owner_address = msg.sender;
        storageDate = block.timestamp;
        tempCOn = TempCondition.Optimum;
        humCOn = HumCondition.Optimum;
        lightCOn = LightExpoCondition.Optimum;
        violationType = ViolationType.None;
    }
    
    modifier OnlyOwner(){
        require(msg.sender == owner_address);
        _;
    }
    
    modifier OnlyStorage(){
        require(msg.sender == storage_address);
        _;
    }
    
    event seedStored(address ad, string  masg);
    event TemperatureViolation(address ad, string masg);
    event HummidityViolation(address ad, string masg);
    event LightExposureViolation(address ad, string masg);
    
    
    function addSeed(
        string memory name,
        string memory bat_id,
        uint quant,
        uint price,
        uint optTem,
        uint optHum,
        uint optLitEx) private OnlyStorage{
            
        seedName = name;
        batch_id = bat_id;
        quantity = quant;
        unitPrice = price;
        optimumTemp = optTem;
        optimumHum = optHum;
        optimumLightExpo = optLitEx;
        
    }
    
    function TemperatureSelfCheck(uint value) public view OnlyStorage returns(string memory){
        if(value > optimumTemp){
            return "Current temperature is over the threshold";
        }else if(value < optimumTemp){
            return "Current temperature is below the threshold";
        }else{
            return "Current temperature is optimum";
        }
    }
    
    function HummiditySelfCheck(uint value) public view OnlyStorage returns(string memory){
        if(value > optimumHum){
            return "Current hummidity is over the threshold";
        }else if(value < optimumTemp){
            return "Current hummidity is below the threshold";
        }else{
            return "Current hummidity is optimum";
        }
    }
    
    function LightExpoSelfCheck(uint value) public view OnlyStorage returns(string memory){
        if(value > optimumLightExpo){
            return "Current light exposure is over the threshold";
        }else if(value < optimumTemp){
            return "Current light exposure is below the threshold";
        }else{
            return "Current light exposure is optimum";
        }
    }
    
    function ViolationTrigger(ViolationType vio, int category) 
        internal OnlyStorage{ //category 1 = over, 0 = under
        
        if(vio == ViolationType.Temperature){
            if(category == 1){
                tempCOn = TempCondition.Over;
                violationType = ViolationType.Temperature;
                emit TemperatureViolation(storage_address, "Temparature is over the threshold");  
            }else{
                tempCOn = TempCondition.Under;
                violationType = ViolationType.Temperature;
                emit TemperatureViolation(storage_address, "Temparature is below the threshold");
            }
        }else if(vio == ViolationType.Hummidity){
            if(category == 1){
                humCOn = HumCondition.Over;
                violationType = ViolationType.Hummidity;
                emit HummidityViolation(storage_address, "Hummidity is over the threshold"); 
            }else{
                humCOn = HumCondition.Under;
                violationType = ViolationType.Hummidity;
                emit HummidityViolation(storage_address, "Hummidity is below the threshold");
            }
            
        }else if(vio == ViolationType.LightExposure){
            if(category == 1){
                lightCOn = LightExpoCondition.Over;
                violationType = ViolationType.LightExposure;
                emit LightExposureViolation(storage_address, "Light exposure is over the threshold");
            }else{
                lightCOn = LightExpoCondition.Under;
                violationType = ViolationType.LightExposure;
                emit LightExposureViolation(storage_address, "Light exposure is below the threshold");
            }
        }
    }
     
    
}
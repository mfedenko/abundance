pragma solidity ^0.4.4;

contract ERC20Interface {
    
    function totalSupply() public constant returns (uint256 totalSupply);
    function balanceOf(address owner) public returns (uint256 balance);
    function allowance(address owner, address spender) public constant returns (uint256 remaining);
    function transfer(address to, uint256 amount) public returns (bool success);
    function approve(address spender, uint256 amount) public returns (bool success);
    function transferFrom(address from, address to, uint256 amount) public returns (bool success);
    
    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Approval(address indexed owner, address indexed spender, uint256 amount);
} 
 /*STILL NEED: Method for allocating ether to Funds.
    RunOff voting system for allocation
    Voter verification specific to Vassar 
    Voter period throughout week donating period throughout the week 
    (possible event) every week 1hr period //Closed voting period for funds to be reallocated by the contract 50 percent equal 50 by vote runoff 
    Storing past votes from previous voting periods 
*/ 

contract EmerFund {
    //Model a Fund
    struct Fund{
        unit id;
        string name;
        unit voteCount;
    }  
    //Store accounts that have voted bool= true means they voted 
    mapping(address => bool) public voters;
    //Store Funds
    //Fetch Fund from storage using mapping (key, value)
    mapping(unit => Fund) public funds;
    //Store Fund Count in storage (keep track of how many there are)
    unit public fundsCount; 

    // voted event 
    event votedEvent( 
        unit indexed _fundId
    );

    function EmerFund () public {
        addFund("Physical Health");
        addFund("Mental Health");
        addFund("Financial Aid");
        addFund("School Supplies");
        addFund("Home Support");
        addFund("Travel");
        addFund("Food");
        addFund("Childcare");
    }
    function addFund (string _name) private {
        //increment the num of fund categories 
        fundsCount ++;
        funds[fundsCount] = Fund(fundsCount, _name, 0);
    }
   
    //vote function
    function vote (unit _fundId) public {
    /*require that they havent voted before (in specific timeframe??)
    msg sender not in mapping
    */
    require(!voters[msg.sender]);
    
    /*require a valid fund (the fund id is greater than 0 and less than the total amount of funds) 
    returns true >> continues executing  vote function 
    */
    require (_fundId > 0 && _fundId <= fundsCount)
    
    //record voters that have already voted 
    voters[msg.sender] = true 


    //Update Fund votecount by 1 
    funds[_fundId].voteCount ++;

    // trigger voted event 
    votedEvent(_fundId);
    }

    //Voter Verification (vassar.edu??)
}

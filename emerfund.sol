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

contract EmerFund {
    //Model a Fund
    struct Fund{
        unit id;
        string name;
        unit voteCount;
    }  

    //Store Funds
    //Fetch Fund from storage using mapping (key, value)
    mapping(unit => Fund) public funds;
    //Store Fund Count in storage (keep track of how many there are)
    unit public fundsCount; 

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
    //Vote function
    function Vote (unit _fundId) public {
    //Voter voted?
    //Update Fund vote 
    fund[_fundId].voteCount ++;
    }
 
}

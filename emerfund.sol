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
 /*STILL NEED: 
Proportional allocation FUNC 
EVENT (use blocktime)// //Close Vote, calculate votes, show results, reset everything to 0 
Voting func: allow voters to input top 1/2/3 ranking 
Voter verification specific to Vassar (in presentation)
Storing past votes from previous voting periods PYTHON TERM 
*/ 

contract EmerFund {
    //Model a Fund
    struct Fund{
        uint id;
        string name;
        uint voteCount;
    }  

    //Store accounts that have voted bool= true means they voted 
    mapping(address => bool) public voters;

    //Fetch Fund from storage using mapping (key, value)
    mapping(uint => Fund) public funds;

    //Store Fund Count in storage (keep track of how many there are)
     uint public fundsCount; 

    // monies variable 
    Var monies (uint)

    //Store monies (display total val??) 
    function TotMonies(uint amount) payable {
        monies += amount
    }

    //Allocating 50 percent Equally
        function equiAll {
    //half monies divided by fundsCount
        halfmoniesDFC = uint((monies / 2) / fundsCount) 
    //do equal allocation to funds 
        for (uint i=0; i<fundsCount; i++) 
        {funds[i] += halfmoniesDFC}
    }

    //proportional allocation
        event proAll {
        halfmonies = uint(monies / 2)
    //do pro allocation to funds 
        for (uint i=0; i<fundsCount; i++) 
        {funds[i] += }
    }

    // voted event 
    event votedEvent( 
        uint  indexed _fundId
    );
    
    //Close Vote, calculate votes, provides results, and reset
    event closeVote(
        returns 
    )

    //Variable (chairperson) 
    var address Admin 

    //Constructor 
    function EmerFund () public {
        addFund("Physical Health");
        addFund("Mental Health");
        addFund("Financial Aid");
        addFund("School Supplies");
        addFund("Home Support");
        addFund("Travel");
        addFund("Food");
        addFund("Childcare"); 
        Admin = msg.sender 
    }

    //Add Fund
    function addFund (string _name) public {
        require (msg.sender == Admin)
        //increment the num of fund categories 
        fundsCount ++;
        funds[fundsCount] = Fund(fundsCount, _name, 0);
    }

    //Remove Fund
    function remFund (string _name) public {
        require (msg.sender == Admin)
        require (_fundId > 0 && _fundId <= fundsCount)
        //decrement the num of fund categories 
        fundsCount --;
        funds[fundsCount] = Fund(fundsCount, _name, 0); //clarify w corin 
    }

    //vote function
    function vote (uint  _fundId) public {
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

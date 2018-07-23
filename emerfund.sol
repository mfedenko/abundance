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
    uint monies 

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

    //total votes variable
    uint TotVote 

    //final allocation of other 50 percent 
    function FinalAll {
        halfmonies = uint(monies / 2)
    //get total votes
        for (uint i=0; i<fundsCount; i++)
        funds[i].voteCount + TotVote;
    //get proportion of each fund's votes amongst TotVote 
        for (uint i=0; i<fundsCount; i++)
        proVote = funds[i].voteCount // TotVote
    //allocate monies proportionally to funds (proportion x total monies)
        for (uint i=0; i<fundsCount; i++)
        proMonies = (proVote x halfmonies) 
        proMonies + funds[i]
    }

    // voted event 
    event votedEvent( 
        uint  indexed _fundId
    );
    
    //Close Vote: shows total votes, votes for each fund 
    // how much monies each fund recieved, calls reset func 
    event closeVote (
        reset
    )

    //resets monie storage, total votes, votes for ind funds
    function reset {
    monies = 0
    TotVote = 0
    for (uint i=0; i<fundsCount; i++)
        funds[i].voteCount = 0 


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

    //Remove Fundblockchain timestamp
    function remFund (string _name) public {
        require (msg.sender == Admin)
        require (_fundId > 0 && _fundId <= fundsCount)
        //decrement the num of fund categories 
        fundsCount --;
        funds[fundsCount] = Fund(fundsCount, _name, 0); //clarify w corin 
    }

    //vote function
    function vote (uint  _fundId) public {
    if TotVote = 0;
        action_time = now

    //require that they havent voted before (in a week), so msg sender is not in mapping//
    require(!voters[msg.sender] && now = (action_time + 1 week)) 
    
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
   
   //trigger close vote event
   closeVote }



   
}


pragma solidity ^0.4.4;

 /*STILL NEED: 
Send funds from contract to Admin
EVENT //Close Vote,  show results, 
Voter verification specific to Vassar (in presentation)
Storing past votes from previous voting periods PYTHON TERM 
*/ 

contract EmerFund {
    //Model a Fund
    struct Fund{
        uint id;
        string name;
        uint voteCount;
        uint monies;
    }  
    //list of voters 
    address[] public votersList; 
    
    //Store accounts that have voted bool= true means they voted 
    mapping(address => bool) public voters;

    //Fetch Fund from storage using mapping (key, value)
    mapping(uint => Fund) public funds;

    //Store Fund Count in storage (keep track of how many there are)
     uint public fundsCount; 

    // monies variable 
    uint monies;

    //Store monies (display total val??) 
    function TotMonies(uint amount) payable {
        monies += amount;
    }
    

    //Allocating 50 percent Equally
    function equiAll () private {
    //half monies divided by fundsCount
        halfmoniesDFC = uint((monies / 2) / fundsCount);
    //do equal allocation to funds 
        for (uint i=0; i<fundsCount; i++){
        funds[i].monies += halfmoniesDFC;
        }
    }

    //total votes variable
    uint TotVote;

    //final allocation of other 50 percent 
    function FinalAll () public {
        require (msg.sender == Admin);
        halfmonies = uint(monies / 2);
    //get proportion of each fund's votes amongst TotVote 
        for (uint i=0; i<fundsCount; i++) {
        proVote = (funds[i].voteCount / TotVote);
    //allocate monies proportionally to funds (proportion x total monies)
        proMonies = (proVote * halfmonies); 
        funds[i].monies +=  proMonies;
        }
        reset; 
    }

    // voted event 
    event votedEvent( 
        uint  indexed _fundId
    );
    
    //Close Vote: shows total votes, votes for each fund 
    // how much monies each fund recieved, 
    // event closeVote (
        // emit TotVote
       // for (uint i=0; i<fundsCount; i++)
        //emit funds[i].voteCount 
        //emit //monies in fund 
        //reset //NEED CORIN HLP 
   // );

    //resets monie storage, total votes, votes for ind funds
    function reset () private {
    monies = 0;
    TotVote = 0;
    for (uint i=0; i<votersList.length; i++){
        voters[votersList[i]] = false;
    }
    for (uint i=0; i<fundsCount; i++){
        funds[i].voteCount = 0 ;
    }
    }


    //Variable (chairperson) 
    address Admin;
    
    //Transfer Monies to Admin <-----
    

    //Constructor 
    constructor EmerFund () public {
        addFund("Physical Health");
        addFund("Mental Health");
        addFund("Financial Aid");
        addFund("School Supplies");
        addFund("Home Support");
        addFund("Travel");
        addFund("Food");
        addFund("Childcare"); 
        Admin = msg.sender;
    }

    //Add Fund
    function addFund (string _name) public {
        require (msg.sender == Admin);
        //increment the num of fund categories 
        fundsCount ++;
        funds[fundsCount] = Fund(fundsCount, _name, 0);
    }

    //Remove Fund
    function remFund (string _name) public {
        require (msg.sender == Admin);
        require (_fundId > 0 && _fundId <= fundsCount);
        //decrement the num of fund categories 
        fundsCount --;
        funds[fundsCount] = Fund(fundsCount, _name, 0); //clarify w corin 
    }

    //vote function
    function vote (uint  _fundId) public {
    //require that they havent voted before (in a week), so msg sender is not in mapping
    require(!voters[msg.sender]);
    
    /*require a valid fund (the fund id is greater than 0 and less than the total amount of funds) 
    returns true >> continues executing  vote function 
    */
    require (_fundId > 0 && _fundId <= fundsCount);
    
    // voterlist 
    votersList.push(msg.sender);
    
    //record voters that have already voted 
    voters[msg.sender] = true;

    //Update Fund votecount by 1 
    funds[_fundId].voteCount ++;
    TotVote ++;

    // trigger voted event 
    votedEvent(_fundId);
   
   //trigger close vote event
   //closeVote }

}
}
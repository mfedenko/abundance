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
        string name;
        uint voteCount;
        uint monies;
    }  
    //list of voters 
    address[] public votersList; 
    
    //Store accounts that have voted bool= true means they voted 
    mapping(address => bool) public voters;

    //Fetch Fund from storage using mapping (key, value)
    Fund[] public funds;

    //Store Fund Count in storage (keep track of how many there are)
     uint public fundsCount; 

    // monies variable 
    uint monies;

    //Store monies (display total val??) 
    function Donate(uint amount) public payable {
        monies += amount;
    }
    

    //Allocating 50 percent Equally
    function equiAll () private {
    //half monies divided by fundsCount
        uint halfmoniesDFC;
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
        uint halfmonies = uint(monies / 2);
    //get proportion of each fund's votes amongst TotVote 
        for (uint i=0; i<fundsCount; i++) {
        uint proVote = (funds[i].voteCount / TotVote);
    //allocate monies proportionally to funds (proportion x total monies)
        uint proMonies = (proVote * halfmonies); 
        funds[i].monies +=  proMonies;
        }
        reset; 
    }

    // voted event 
    event votedEvent( 
        uint  indexed _fundId
    );
    
    
    function votingInfo () public{
    uint [] storage FundVotes;
    uint [] storage FundMonies; 
       for (uint i=0; i<fundsCount; i++){ 
            FundVotes.push(funds[i].voteCount);
            FundMonies.push(funds[i].monies);
       }
           emit closeVote(TotVote,FundVotes,FundMonies); 
    }
        
    
    
    //Close Vote: shows total votes, votes for each fund,  how much monies each fund recieved
    event closeVote(
    uint TV, // Total Votes 
    uint[] FundVotes,
    uint[] FundMonies
        );

    //resets monie storage, total votes, votes for ind funds
    function reset () private {
    monies = 0;
    TotVote = 0;
    for (uint i=0; i<votersList.length; i++){
        voters[votersList[i]] = false;
    }
    for (uint n=0; n<fundsCount; n++){
        funds[n].voteCount = 0 ;
    }
    }


    //Variable (chairperson) 
    address Admin;
    
        // into three phases:
        // 1. checking conditions
        // 2. performing actions (potentially changing conditions)
        // 3. interacting with other contracts
        
    //Get Monies to Admin function <-----
    function getMonies () public {
    require (msg.sender == Admin);
    Admin.transfer(monies);
    }

    //Constructor 
    constructor () public {
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
        funds.push(Fund( _name, 0, 0));
    }

    //Remove Fund
    function remFund (string _name) public {
        require (msg.sender == Admin);
        for (uint i=0; i<funds.length; i++){
            if (keccak256(abi.encodePacked(funds[i].name))== keccak256(abi.encodePacked (_name))) {
                delete funds[i];
                //decrement the num of fund categories 
                fundsCount --;
                break ;
            }
        }

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
    emit votedEvent(_fundId);
   
   //trigger close vote event
   //closeVote }

}
}
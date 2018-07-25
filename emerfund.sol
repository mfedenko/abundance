pragma solidity ^0.4.4;

/* STILL NEED
Voter verification specific to Vassar (in presentation)
Storing past votes from previous voting periods PYTHON TERM 
*/ 
contract EmerFund {
    //Model a Fund
    struct Fund{
        uint voteCount;
        uint monies;
    }
    
    //total votes variable
    uint TotVote;
    
    //Variable (chairperson) 
    address Admin;
    
    //list of voters 
    address[] public votersList; 
    
    //Store accounts that have voted bool= true means they voted 
    mapping(address => bool) private voters;

    //Fetch Fund from storage using mapping (key, value)
    mapping(string => Fund) private fundlist;

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
        fundlist["Physical Health"].monies += halfmoniesDFC;
        fundlist["Mental Health"].monies += halfmoniesDFC;
        fundlist["Financial Aid"].monies += halfmoniesDFC;
        fundlist["School Supplies"].monies += halfmoniesDFC;
        fundlist["Home Support"].monies += halfmoniesDFC;
        fundlist["Travel"].monies += halfmoniesDFC;
        fundlist["Food"].monies += halfmoniesDFC;
        fundlist["Childcare"].monies += halfmoniesDFC;
    }


    //final allocation of other 50 percent 
    function FinalAll () public {
        require (msg.sender == Admin);
        uint halfmonies = uint(monies / 2);
        
    //get proportion of each fund's votes amongst TotVote 
        fundlist["Physical Health"].monies += (fundlist["Physical Health"].voteCount/TotVote) * halfmonies;
        fundlist["Mental Health"].monies += (fundlist["Mental Health"].voteCount/TotVote) * halfmonies;
        fundlist["Financial Aid"].monies += (fundlist["Financial Aid"].voteCount/TotVote) * halfmonies;
        fundlist["School Supplies"].monies += (fundlist["School Supplies"].voteCount/TotVote) * halfmonies;
        fundlist["Home Support"].monies += (fundlist["Home Support"].voteCount/TotVote) * halfmonies;
        fundlist["Travel"].monies += (fundlist["Travel"].voteCount/TotVote) * halfmonies;
        fundlist["Food"].monies += (fundlist["Food"].voteCount/TotVote) * halfmonies;
        fundlist["Childcare"].monies += (fundlist["Childcare"].voteCount/TotVote) * halfmonies;
    }

    // voted event 
    event votedEvent( 
        string _fundId
    );
    
    
    function votingInfo () public{
        uint [8] memory FundVotes = [fundlist["Physical Health"].voteCount, fundlist["Mental Health"].voteCount, fundlist["Financial Aid"].voteCount, fundlist["School Supplies"].voteCount, fundlist["Home Support"].voteCount, fundlist["Travel"].voteCount, fundlist["Food"].voteCount, fundlist["Childcare"].voteCount];
        uint [8] memory FundMonies = [fundlist["Physical Health"].monies, fundlist["Mental Health"].monies, fundlist["Financial Aid"].monies, fundlist["School Supplies"].monies, fundlist["Home Support"].monies, fundlist["Travel"].monies, fundlist["Food"].monies, fundlist["Childcare"].monies]; 
        emit closeVote(TotVote,FundVotes,FundMonies); 
    }
        
    
    //Close Vote: shows total votes, votes for each fund,  how much monies each fund recieved
    event closeVote(
        uint TV, // Total Votes 
        uint[8] FundVotes,
        uint[8] FundMonies
    );
        
    //Get Monies to Admin function <-----
    function getMonies () public {
        require (msg.sender == Admin);
        Admin.transfer(monies);
    }

    //Constructor 
    constructor () public {
        fundlist["Physical Health"] = Fund(0, 0);
        fundlist["Mental Health"] = Fund(0, 0);
        fundlist["Financial Aid"] = Fund(0, 0);
        fundlist["School Supplies"] = Fund(0, 0);
        fundlist["Home Support"] = Fund(0, 0);
        fundlist["Travel"] = Fund(0, 0);
        fundlist["Food"] = Fund(0, 0);
        fundlist["Childcare"] = Fund(0, 0);
        Admin = msg.sender;
        
    }

    //vote function
    function vote (string _fundId) public {
        //require that they havent voted before (in a week), so msg sender is not in mapping
        require(!voters[msg.sender]);
    
        //voterlist 
        votersList.push(msg.sender);
        
        //record voters that have already voted 
        voters[msg.sender] = true;
    
        //Update Fund votecount by 1 
        fundlist[_fundId].voteCount ++;
        TotVote ++;
    
        // trigger voted event 
        emit votedEvent(_fundId);
       
       //trigger close vote event
       //closeVote }

    }
}
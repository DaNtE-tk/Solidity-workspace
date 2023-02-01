//SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.5.0 < 0.9.0;

contract CrowdFunding{
    mapping(address=>uint) public contributors;
    address public manager;
    uint public minimumContribution;
    uint public deadline;
    uint public target;
    uint public raisedAmount;
    uint public noOfContributors;

    //structure for request consensus
    struct Request{
        string description;
        address payable recipient;
        uint value;
        bool completed;
        uint noOfVoters;
        mapping(address=>bool)voters;
    }

    mapping(uint=>Request)public requests;
    uint public numRequests;

    constructor(uint _target, uint _deadline){
        target = _target;
        deadline = block.timestamp +_deadline;
        minimumContribution = 100 wei;
        manager = msg.sender;
    }

    function sendEth()public payable{
        require(block.timestamp<deadline, "Deadline has passed.");
        require(msg.value >= minimumContribution,"Minimum contribution not met.");

        if(contributors[msg.sender]==0){
            noOfContributors++;
        }
        contributors[msg.sender]+=msg.value;
        raisedAmount+=msg.value;
    }

    function getContractBalance() public view returns(uint){
        return address(this).balance;
    }

    function getRefund()public{
        require(block.timestamp>deadline && raisedAmount<target,"Not eligible for refund!");
        require(contributors[msg.sender]>0);
        address payable user = payable(msg.sender);
        user.transfer(contributors[msg.sender]);
        contributors[msg.sender]=0;
    }


    //Consensus
    modifier onlyManager(){
        require(msg.sender == manager,"Only manager can call this function.");
        _;
    }

    function createRequest(string memory _description, address payable _recepient, uint _value)public onlyManager{
        Request storage newRequest = requests[numRequests];
        numRequests++;
        newRequest.description=_description;
        newRequest.recipient = _recepient;
        newRequest.value = _value;
        newRequest.completed = false;
        newRequest.noOfVoters = 0;
    }
    
    function voteRequest(uint _requestNo)public{
        require(contributors[msg.sender]>0,"Not a contributor.");
        Request storage thisRequest = requests[_requestNo];
        require(thisRequest.voters[msg.sender]==false,"You have already voted.");
        thisRequest.voters[msg.sender]=true;
        thisRequest.noOfVoters++;
    }

    function makePayment(uint _requestNo)public onlyManager{
        require(raisedAmount>=target);
        Request storage thisRequest = requests[_requestNo];
        require(thisRequest.completed==false,"Request already fulfilled.");
        require(thisRequest.noOfVoters > noOfContributors/2,"Consensus failed.");
        thisRequest.recipient.transfer(thisRequest.value);
        thisRequest.completed=true;
    }
}
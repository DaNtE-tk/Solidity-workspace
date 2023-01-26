//SPDX-License-Identifier: UNLICNESED

pragma solidity >=0.5.0 <0.9.0;

contract EventContract{
    struct Event{
        address organizer;
        string name;
        uint date;
        uint price;
        uint ticketCount;
        uint ticketRemain;
    }
    mapping(uint=>Event) public events;
    mapping(address=>mapping(uint=>uint))public tickets;
    uint public nextId;

    function createEvent(string memory name, uint date, uint price, uint ticketCount) external {
        require(date>block.timestamp,"You can organise event for future.");
        require(ticketCount>10,"There must me more than 10 slots.");
         
         events[nextId] = Event(msg.sender,name,date,price,ticketCount,ticketCount);
         nextId++;
    }

    function buyTicket(uint id, uint quantity)external payable{
        require(events[id].date!=0,"This event does not exist.");
        require(events[id].date>block.timestamp,"Event ended!");
        Event storage _event = events[id];
        require(msg.value==(_event.price*quantity),"Not enough Ether");
        require(_event.ticketRemain>=quantity,"Not enough tickets");
        _event.ticketRemain-=quantity;
        tickets[msg.sender][id]+=quantity;
    }

    function transferTicket(uint id,uint quantity,address to)external{
        require(events[id].date!=0,"This event does not exist.");
        require(events[id].date>block.timestamp,"Event ended!");
        require(tickets[msg.sender][id]>=quantity,"Not enough tickets");
        tickets[msg.sender][id]-=quantity;
        tickets[to][id]+=quantity;
    }
}
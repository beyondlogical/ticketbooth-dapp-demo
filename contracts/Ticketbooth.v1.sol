pragma solidity ^0.4.21;

/*

We want to issue tickets for our events, so we'll set up a self service ticket booth on the Ethereum blockchain!

What are we looking for?

When we create the ticketbooth, we'll initialize it with the ticket information.
To inform folks of what they're getting, we'll include a name for the event and a description with relevant details (time, location, etc.)
We'll want to put a limit on the number of tickets available, due to capacity, etc.
We might want to change that information later, and we don't want just anyone changing it.
We'll want to be able to see how many tickets are left.
We'll also want to see who we've given tickets to. Ideally, only the owner should be able to do that.

In this scenario, we don't actually issue a ticket/token/receipt to the attendee,
we simply allow them to sign up on the list.

Checking the list to see who has a "ticket" is a bit onerous though...
we need to iterate through the list manually and compare addresses. :(

*/

contract Ticketbooth {
    address public ticketMaster;
    string public eventName;
    string public eventDescription;
    uint public ticketsLeft;
    address[] public ticketHolders;

    modifier onlyTicketMaster() {
        require(msg.sender == ticketMaster);
        _;
    }

    modifier stillTicketsLeft() {
        require(ticketsLeft >= 1);
        _;
    }
    
    /*
    * The constructor, called when the contract is deployed
    */
    function Ticketbooth (
        uint _ticketsLeft,
        string _eventName,
        string _eventDescription
    ) public {
        ticketMaster = msg.sender;
        eventName = _eventName;
        eventDescription = _eventDescription;
        ticketsLeft = _ticketsLeft;
    }

    function getTicket () public stillTicketsLeft {
        ticketHolders.push(msg.sender);
        ticketsLeft -= 1;
    }

    function updateTicketsLeft (
        uint _ticketsLeft
    ) public onlyTicketMaster {
        ticketsLeft = _ticketsLeft;
    }

}

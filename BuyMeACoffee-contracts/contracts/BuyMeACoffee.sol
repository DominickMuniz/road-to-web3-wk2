//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

// Deployed to Goerli at 0xA21D3f052772c8f066443eBa1669f56a799d6299

contract BuyMeACoffee {
    // Event to emit when a Memo is created. 
    event NewMemo(
        address indexed from, 
        uint256 timestamp,
        string name,
        string message
    );

    // Memo struct.
    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    // List of all memos recieved from friends.
    Memo[] memos;

    // Address of contract deplyoer.
    address payable owner;

    // Deploy Logic.
    constructor() {
        owner = payable(msg.sender);
    }


    /**
    * @dev buy a coffee for contract owner 
    * @param _name name of the coffee b uyer
    * @param _message a nice message from the coffee buyer
    */
    function buyCoffee(string memory _name, string memory _message) public payable {
        require(msg.value > 0, "can't buy coffee with 0 eth");
        
        // Add the memo to storage.
        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));

        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message            
        );
    }



    /**
    * @dev send the entire balance stored in this contract to the owner
    */
    function withdrawTips() public {
        
        require(owner.send(address(this).balance));

    }


    /**
    * @dev retrieve all the memos recieved and stored on the blockchain
    */
    function getMemos() public view returns(Memo[] memory) {
        return memos;
    }


}

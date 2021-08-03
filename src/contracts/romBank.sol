// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

import "./Token.sol";

contract romBank {
  //state variable
  Token private token;
 
  mapping(address => uint) public etherBalanceOf;
  mapping(address => uint) public depositStart;
  mapping(address => bool) public isDeposited;

  //events
  event Deposit(address indexed user, uint etherAmount, uint timeStart);




  //token in constructor is local variable
  constructor(Token _token) public {

    token = _token;
  
  }

  function deposit() payable public {

    require(isDeposited[msg.sender] == false, 'Error deposit already active');
    require(msg.value>=1e16, 'Error, deposit must be >= 0.01 ETH');
    etherBalanceOf[msg.sender] = etherBalanceOf[msg.sender] + msg.value;
    
    depositStart[msg.sender] = depositStart[msg.sender] + block.timestamp;
    
    isDeposited[msg.sender] = true;
    emit Deposit(msg.sender, msg.value, block.timestamp);
  }

  function withdraw() public {
    
    //check users hold time
    uint depositTime = block.timestamp - depositStart[msg.sender];
    
    //sends eth to user
    msg.sender.transfer(etherBalanceOf[msg.sender]);
    //reset depositer data
    etherBalanceOf[msg.sender] = 0;
  }

  function borrow() payable public {

  }

  function payOff() public {
   
  }
}
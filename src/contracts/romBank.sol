// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

import "./Token.sol";

contract romBank {
  //state variable
  Token private token;
 
  mapping(address => uint) public etherBalanceOf;
  mapping(address => uint) public depositStart;

  //token in constructor is local variable
  constructor(Token _token) public {

    token = _token;
  
  }

  function deposit() payable public {

    etherBalanceOf[msg.sender] = etherBalanceOf[msg.sender] + msg.value;
    depositStart[msg.sender] = depositStart[msg.sender] + block.timestamp;


  }

  function withdraw() public {
 
  }

  function borrow() payable public {

  }

  function payOff() public {
   
  }
}
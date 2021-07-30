// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

import "./Token.sol";

contract romBank {
  //state variable
  Token private token;
 
  //token in constructor is local variable
  constructor(Token _token) public {
   token = _token;
  }

  function deposit() payable public {
 
  }

  function withdraw() public {
 
  }

  function borrow() payable public {

  }

  function payOff() public {
   
  }
}
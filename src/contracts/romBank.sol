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
  event Withdraw(address indexed user, uint etherAmount, uint depositTime, uint interest);



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
    
    //checks to see if they deposited
    require(isDeposited[msg.sender] == true, 'Error, no previous deposit');
    //use this to track event
    uint userBalance = etherBalanceOf[msg.sender];


    //check users hold time
    uint depositTime = block.timestamp - depositStart[msg.sender];
    

    uint interestPerSecond = 31668017 * (etherBalanceOf[msg.sender] / 1e16);
    uint interest = interesPerSecond * depositTime;
    //sends eth to user
    msg.sender.transfer(etherBalanceOf[msg.sender]);
    token.mint(msg.sender, interest);

    //reset depositer data
    depositStart[msg.sender] = 0;
    etherBalanceOf[msg.sender] = 0;
    isDeposited[msg.sender] = false;

    //event
    emit Withdraw(msg.sender, userBalance, depositTime, interest);
  }

  function borrow() payable public {

  }

  function payOff() public {
   
  }
}
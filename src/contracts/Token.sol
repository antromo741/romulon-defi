// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
  address public minter;

  //add minterchanged event

  constructor() public payable ERC20("Decentralized Bank Currency", "DCB") {
    minter = msg.sender;
  }

  //Add pass minter role function

  function mint(address account, uint256 amount) public {
    require(msg.sender == minter, 'Error, msg.sender does not have the minter role');
		_mint(account, amount);
	}
}
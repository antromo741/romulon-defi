// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
  address public minter;

 

  constructor() public payable ERC20("Decentralized Bank Currency", "DCB") {
    minter = msg.sender;
  }

  function passMinterROle(address dbank) public returns(bool) {
    require(msg.semder==minter, 'Error, onlu owner can change pass minter role');
    minter = dbank;

    emit MinterChanged(msg.semder, dbank);
    return true;
  }

  function mint(address account, uint256 amount) public {
    require(msg.sender==minter, 'Error, msg.sender does not have the minter role');
		_mint(account, amount);
	}
}
const Token = artifacts.require("Token");
const romBank = artifacts.require("romBank");

module.exports = async function (deployer) {
    //deploy Token
    await deployer.deploy(Token)

    //assign token into variable to get it's address
    const token = await Token.deployed()

    //pass token address for romBank contract(for future minting)
    await deployer.deploy(romBank, token.address)

    //assign romBank contract into variable to get it's address
    const rombank = await romBank.deployed()

    //change token's owner/minter from deployer to romBank
    await token.passMinterRole(rombank.address)
};
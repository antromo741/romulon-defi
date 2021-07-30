const Token = artifacts.require("Token");
const romBank = artifacts.require("romBank")

module.exports = async function (deployer) {
    //deploy
    await deployer.deploy(Token)

    //assign token to varaible to get address
    const token = await Token.deployed()

    //pass token address for romBank contract to allow future minting
    await deployer.deploy(romBank, token.address)

    //assign rombank contract into varaible to get its address
    const romBank = await romBank.deployed()

    //change the minter or token owner from who deploys romBank
    await token.passMinterRole(romBank.address)


};

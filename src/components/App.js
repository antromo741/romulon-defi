import { Tabs, Tab } from 'react-bootstrap';
import React, { Component } from 'react';
import romBank from '../abis/romBank.json';
import Token from '../abis/Token.json'  ;

import Web3 from 'web3';
import './App.css';


//Add loan options to token
class App extends Component {

  async componentWillMount() {
    await this.loadBlockchainData(this.props.dispatch)
  }

  async loadBlockchainData(dispatch) {

    //check if MetaMask exists
    if(typeof window.ethereum!=='undefined'){

      const web3 = new Web3(window.ethereum)
      const netId = await web3.eth.net.getId()
      const accounts = await web3.eth.getAccounts()

      if(typeof accounts[0] !=='undefined'){
        const balance = await web3.eth.getBalance(accounts[0])
        this.setState({ account: accounts[0], balance: balance, web3: web3})
      } else {
        window.alert('Please login wih MetaMask')
      }
      try{
      const token = new web3.eth.Contract(Token.abi, Token.networks[netId].address)
      const rombank = new web3.eth.Contract(romBank.abi, romBank.networks[netId].address)
      const romBankAddress = romBank.networks[netId].address

      //Also need to add tab to see interest
      //Need to elaborate on this part to figure out interest"
      const tokenBalance = await token.methods.balanceOf(this.state.account).call()
      console.log(web3.utils.fromWei(tokenBalance))
      this.setState({token: token, romBank: romBank, romBankAddress: romBankAddress})
      } catch (e) {
        console.log('Error', e)
        window.alert('Contracts not deployed to the current network')
      }

    } else {
      window.alert('Please install MetaMask, Import an account from Ganache and add the Ganache private Network')
    }
   
  }

  async deposit(amount) {
    console.log(amount)
      if(this.state.rombank!=='undefined'){
        try{
      
      await this.state.rombank.methods.deposit().send({value: amount.toString(), from: this.state.account})
      } catch (e) {
        console.log('Error, deposit: ', e)
      }
    }
  }

  async withdraw(e) {
    if (this.state.rombank !== 'undefined') {
      try {

        await this.state.rombank.methods.withdraw().send({ from: this.state.account })
      } catch (e) {
        console.log('Error, withdraw: ', e)
      }
    }
  }

  constructor(props) {
    super(props)
    this.state = {
      web3: 'undefined',
      account: '',
      token: null,
      rombank: null,
      balance: 0,
      romBankAddress: null
    }
  }

  render() {
    return (
      <div className='text-monospace'>
        <nav className="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow">
          <a
            className="navbar-brand col-sm-3 col-md-2 mr-0"
            href="http://www.dappuniversity.com/bootcamp"
            target="_blank"
            rel="noopener noreferrer"
          >
            <img src={rombank} className="App-logo" alt="logo" height="32" />
            <b>romBank</b>
          </a>
        </nav>
        <div className="container-fluid mt-5 text-center">
          <br></br>
          <h1>Welcome to romBank</h1>
          <h2>{this.state.account}</h2>
          <br></br>
          <div className="row">
            <main role="main" className="col-lg-12 d-flex text-center">
              <div className="content mr-auto ml-auto">
                <Tabs defaultActiveKey="profile" id="uncontrolled-tab-example">
                  <Tab eventKey="deposit" title="Deposit">
                    <div>
                      <br></br>
                      How much do you want to deposit?
                      <br></br>
                      (min. amount is 0.01 ETH)
                      <br></br>
                      (1 deposit is possible at the time)
                      <br></br>
                      <form onSubmit={(e) => {
                        e.preventDefault()
                        let amount = this.depositAmount.value
                        amount = amount * 10**18 //comeback and use toWei()
                      }}>
                        <div className='form-group mr-sm-2'>
                          <br></br>
                          <input
                              className='form-control form-control-md'
                              id='depositAmount'
                              placeholder='Amount?'
                              step="0.01"
                              type='number'
                              required
                              ref={(input) => { this.depositAmount = input }}
                          />
                        </div>
                        <button type ='submit' className='btn btn-primary'>Deposit</button>
                      </form>
                    </div>
                  </Tab>
                  <Tab eventKey="withdraw" title="Withdraw">
                    <div>
                      <br></br>
                      Do you want to withdraw everything and take interest?
                      <br></br>
                      <br></br>
                      <div>
                        <button type='submit' className='btn btn-primary' onClick={(e) => this.withdraw(e)}>
                        WITHDRAW
                        </button>
                      </div>
                    </div>
                  </Tab>
                </Tabs>
              </div>
            </main>
          </div>
        </div>
      </div>
    );
  }
}

export default App;
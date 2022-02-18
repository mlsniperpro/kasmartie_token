//SPDX-License-Identifier:MIT
pragma solidity ^0.8.2;

contract Token{
    mapping(address => uint) balances; //Tracking token balances for each address
    mapping(address => mapping(address => uint)) public allowance;
    uint public totalSupply = 100000*10**18;
    string public name = "Kasmartie";
    string public symbol = "KAST";
    uint public decimals = 18;

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);

    constructor(){
        balances[msg.sender] = totalSupply;
    }
    function balanceOf(address owner) public view returns(uint){
        return balances[owner];
    }
    function transfer(address to, uint value) public returns(bool){
        require(balanceOf(msg.sender) >= value, "balance too low");
        balances[to] += value;
        balances[msg.sender] -= value;
        emit Transfer(msg.sender, to, value);
        return true;
    }
    function transferFrom(address from, address to, uint value) public returns(bool){
        require(balanceOf(from)>= value, "balance too low" );
        require(allowance[from][msg.sender] >= value, "Allowance too low");
        balances[to] += value;
        balances[from] -= value;
        Transfer(from, to, value);
        return true;
    }
    function approve(address spender, uint value) public returns(bool){
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }
}
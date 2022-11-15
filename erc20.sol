// SPDX-License-Identifier: MIT
//Created by: manuDev - estudioscrypto
//github: https://github.com/estudioscrypto
//contact: manudev.oficial@gmail.com
//standard erc20 token

pragma solidity ^0.8.10;

interface IERC20 {
    function totalSupply() external view returns (uint);
    function balanceOf(address account) external view returns (uint);
    function transfer(address recipient, uint amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint);
    function approve(address spender, uint amount) external returns (bool);
    function transferFrom( address sender,address recipient,uint amount ) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}

contract CCT is IERC20 {

    string public name = "Token name";
    string public symbol = "SYMBOL";
    uint8 public decimals = 18;
    uint public totalSupply = 1000000*10**18;
    mapping(address => uint) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;
    //address public Owner;

    constructor() {
        //Owner = msg.sender;
        balanceOf[msg.sender] = totalSupply;
        emit Transfer(address(0), msg.sender, totalSupply);
    }

    function transfer(address recipient, uint amount) external returns (bool) {
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool) {
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    function burn(uint amount) public {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }

    /*
    modifier onlyOwner() {
        require(msg.sender == Owner, "ERROR: YOU NOT OWNER");
        _;
    }

    function mint(uint amount) public onlyOwner{
        totalSupply = totalSupply+amount;
        balanceOf[msg.sender] += amount;
        emit Transfer(address(0), Owner, amount);
    }
    */
}
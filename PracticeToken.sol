// SPDX-License-Identifier: MIT
pragma solidity >= 0.5.9;

contract PracticeToken {

    address owner;
    string public tokenName = "PracticeToken";
    string public tokenSymbol = "PT";
    uint8 public decimals = 10;
    uint256 public totalSupply;
    uint256 decimalFactor = 10 ** uint256(decimals);
    uint256 public MAX_TOKEN = 10000 * decimalFactor;


    mapping(address=>uint256) balance;
    mapping(address => mapping(address=>uint256)) public allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approve(address indexed spender, uint256 value);


    constructor() {
        owner = msg.sender;
        totalSupply = MAX_TOKEN;

        balance[owner] = totalSupply;
    }

    function balanceOf(address _address) public view returns(uint256) {
        return balance[_address];
    }

    function _transfer(address _from, address _to, uint256 _value) internal {

        require(_to != address(0));
        require(balance[msg.sender] >= _value);

        balance[_from] = balance[_from] - _value;
        balance[_to] = balance[_to] + _value;

        emit Transfer(_from, _to, _value);
    }

    function transfer(address _to, uint256 _value) public returns(bool){
        _transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns(bool) {
        require(_value <= allowance[_from][msg.sender], "Allowance Error");
        allowance[_from][msg.sender] -= _value;
        _transfer(_from, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns(bool) {
        allowance[msg.sender][_spender] = _value;
        emit Approve(_spender, _value);
        return true;
    }


}
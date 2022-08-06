// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 < 0.9.0;
 
// contract is named veektoken
contract veekToken {
    uint256 public totalSupply = 10000000000000000000000000;
    // token name
    string public name = 'veekToken';
    // token symbol
    string public symbol = 'VTC';

    string public standard = 'veek v1.0';
    uint8 public decimals = 18;
 
//  transfer function
    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 _value
    );
 
//  Approve function
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

// To check account balance
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
 
//  owner has total supply
    constructor() {
        balanceOf[msg.sender] = totalSupply;
    }
 
//  Function to enable transfer of coin
    function transfer(address _to, uint256 _value) public returns (bool success) {
        assert(balanceOf[msg.sender] >= _value);
 
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
 
        emit Transfer(msg.sender, _to, _value);
 
        return true;
    }
 
//  Function to approve spending 
    function approve(address _spender, uint256 _value) public returns (bool success) {
        // Add spender to the allowed addresses to spend a value
        allowance[msg.sender][_spender] = _value;
 
        emit Approval(msg.sender, _spender, _value);
 
        return true;
    }
 
//  Transfer from function
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        // Checks spender(@var _from) has enough balance
        assert(balanceOf[_from] >= _value && allowance[_from][msg.sender] >= _value);
        // Update balances
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        // Updates/resets the allowance previously set
        allowance[_from][msg.sender] -= _value;
 
        emit Transfer(_from, _to, _value);
 
        return true;
    }
}

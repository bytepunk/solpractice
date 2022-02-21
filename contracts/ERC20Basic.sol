pragma solidity >=0.4.22 <0.9.0;

/**
 * @title ERC20Basic
 * @dev Simpler version of ERC20 interface.
 * See https://github.com/ethereum/EIPs/issues/179
 */
abstract contract ERC20Basic {
    // Total supply of token.
    function totalSupply() virtual public view returns (uint256);
    // Balance of a holder _who
    function balanceOf(address _who) virtual public view returns (uint256);
    // Transfer _value from msg.sender to receiver _to.
    function transfer(address _to, uint256 _value) virtual public returns (bool);
    // Fired when a transfer is made
    event Transfer(
        address indexed from,
        address indexed to,
        uint256 value
    );
}
pragma solidity >=0.4.22 <0.9.0;

import "./ERC20.sol";
import "./SafeMath.sol";

contract CAT is ERC20 {
    using SafeMath for uint256;

    string public constant name = "CAT Token";
    string public constant symbol="CAT";

    uint8 public constant decimals=18;
    uint internal totalSupply_;

    mapping(address=>uint) public balances;
    mapping(address=>mapping(address=>uint)) allowed;


    constructor() public {
        totalSupply_=1*(10**10)*(10**18);
        balances[msg.sender]=totalSupply_;
        emit Transfer(0, msg.sender, totalSupply_);
    }

    function totalSupply() override public view returns (uint) {
        return totalSupply_;
    }

    function balanceOf(address _owner) override public view returns (uint) {
        return balances[_owner];
    }

    function transfer(address _to, uint _value) override public returns (bool) {
        require(_to!=address(0), "can not send to zero address");
        require(_value<=balances[msg.sender], "msg.sender balance is not enough");

        balances[msg.sender]=balances[msg.sender].sub(_value);
        balances[_to]=balances[_to].add(_value);
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function allowance(address _owner, address _spender) override public view returns (uint) {
        return allowed[_owner][_spender];
    }

    function transferFrom(address _from, address _to, uint _value) override public returns (bool) {
        require(_value <= balances[_from], "_from dos not have enough balance");
        require(_value<=allowed[_from][msg.sender], "allowance of msg.sender is not enough");

        balances[_from]=balances[_from].sub(_value);
        balances[_to]=balances[_to].add(_value);
        allowed[_from][msg.sender]=allowed[_from][msg.sender].sub(_value);
        emit Transfer(_from, _to, _value);
        return true;
    }

    function approve(address _spender, uint _value) override public returns (bool) {
        allowed[msg.sender][_spender]=_value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
}
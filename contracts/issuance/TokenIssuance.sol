pragma solidity ^0.5.2;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "./IssuerRole.sol";
import "../checks/TransferChecker.sol";
import "./ITokenIssuance.sol";

// ERC1594 part: Token Issuance
contract TokenIssuance is ERC20, TransferChecker, IssuerRole, ITokenIssuance {
    using SafeMath for uint256;

    uint256 public capacity;

    constructor(uint256 _cap) internal {
        capacity = _cap;
    }

    function _issuanceAllowed(uint256 amount) internal view returns (bool) {
        uint256 hypotheticalSupply = totalSupply().add(amount);
        return (hypotheticalSupply <= capacity);
    }

    function isIssuable() external view returns (bool) {
        return _issuanceAllowed(1 wei);
    }
      
    /**
     * @dev Verify if tokens can be issued. Note that investors can retrieve their tokens with calldata (that's not currently implemented)
     * @param _tokenholder address to where the token will be issued
     * @param _value The amount to be issued
     * @param _data Extra data to use when checking issuing permissions (not implemented)
     */

    function issue(address _tokenHolder, uint256 _value, bytes calldata _data) external onlyIssuer {

        require(_issuanceAllowed(_value));
        byte status = _canTransfer(address(0x0), _tokenHolder, _value, _data);
        
        require(status == hex"11");
        _mint(_tokenHolder, _value);

        emit Issued(msg.sender, _tokenHolder, _value, _data);
    }

}
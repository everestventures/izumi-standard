pragma solidity ^0.5.2;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "./ITokenRedemption.sol";
import "../checks/TransferChecker.sol";

// ERC1594 part: Token Redemption
contract TokenRedemption is ERC20, TransferChecker, ITokenRedemption {

    /**
     * @dev burn one's tokens
     * @param _value The amount to be burned
     * @param _data Extra data to use when checking burning permissions (not implemented)
     */

    function redeem(uint256 _value, bytes calldata _data) external {

        byte status = _canTransfer(msg.sender, address(0x0), _value, _data);
        require(status == hex"11");

        _burn(msg.sender, _value);

        emit Redeemed(msg.sender, msg.sender, _value, "");
    }

    /**
     * @dev burn somebody's tokens
     * @param _tokenholder address from where token will be burned
     * @param _value The amount to be burned
     * @param _data Extra data to use when checking burning permissions (not implemented)
     */

    function redeemFrom(address _tokenHolder, uint256 _value, bytes calldata _data) external {

        byte status = _canTransfer(_tokenHolder, address(0x0), _value, _data);
        bool regStatus = _canForceTransfer(msg.sender);
        require(status == hex"11");

        if (regStatus) {

            _burn(_tokenHolder, _value);

            emit ForceRedeemed(msg.sender, _tokenHolder, _value, "", msg.sender);
        } else {

            _burnFrom(_tokenHolder, _value);

            emit Redeemed(msg.sender, _tokenHolder, _value, "");
        }
    }

}
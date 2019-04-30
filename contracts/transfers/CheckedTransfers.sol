pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "./ICheckedTransfers.sol";
import "../checks/TransferChecker.sol";

contract CheckedTransfers is ERC20, TransferChecker, ICheckedTransfers {
    using SafeMath for uint256;

    // Note: be sure to override the ERC-20 here, and enforce checking the transfer.
    /**
     * @dev Transfer token to a specified address. Checked by transfer checker.
     * @param to The address to transfer to.
     * @param value The amount to be transferred.
     */
    function transfer(address to, uint256 value) public returns (bool) {
        byte status = _canTransfer(msg.sender, to, value, "");
        require(status == hex"11");
        _transfer(msg.sender, to, value);
        return true;
    }

    // Note: be sure to override the ERC-20 here, and enforce checking the transfer.
    /**
     * @dev Transfer tokens from one address to another. Checked by transfer checker.
     * Note that while this function emits an Approval event, this is not required as per the specification,
     * and other compliant implementations may not emit the event.
     * @param from address The address which you want to send tokens from
     * @param to address The address which you want to transfer to
     * @param value uint256 the amount of tokens to be transferred
     */
    function transferFrom(address from, address to, uint256 value) public returns (bool) {
        byte status = _canTransfer(from, to, value, "");
        bool regStatus = _canForceTransfer(msg.sender);
        require(status == hex"11");
        
        if (regStatus) {
            _transfer(from, to, value);
            emit ForceTransfer(from, to, value, msg.sender);
        } else {
            super.transferFrom(from, to, value);
        }
       
        return true;
    }

    /** 
     * @dev Transfer token to a specified address. Checked by transfer checker.
     * @param _to The address to transfer to.
     * @param _value The amount to be transferred.
     * @param _data Extra data to use when checking transfer permissions.
     */
    function transferWithData(address _to, uint256 _value, bytes calldata _data) external {
        byte status = _canTransfer(msg.sender, _to, _value, _data);
        require(status == hex"11");
        _transfer(msg.sender, _to, _value);
    }

    /**
     * @dev Transfer token to a specified address. Checked by transfer checker.
     * @param _to The address to transfer from.
     * @param _to The address to transfer to.
     * @param _value The amount to be transferred.
     * @param _data Extra data to use when checking transfer permissions.
     */
    function transferFromWithData(address _from, address _to, uint256 _value, bytes calldata _data) external {
        byte status = _canTransfer(msg.sender, _to, _value, _data);
        require(status == hex"11");
        bool regStatus = _canForceTransfer(msg.sender);

        if (regStatus) {
            _transfer(_from, _to, _value);
            emit ForceTransfer(_from, _to, _value, msg.sender);
        } else {
            transferFrom(_from, _to, _value);
        }
    }

}
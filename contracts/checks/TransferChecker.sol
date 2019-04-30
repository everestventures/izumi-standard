pragma solidity ^0.5.2;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "./ITransferChecker.sol";
import "../regulator/IRegulatorService.sol";

contract TransferChecker is ERC20, ITransferChecker {

    IRegulatorService public reg;

    function _canTransfer(address _from, address _to, uint256 _value, bytes memory _data) internal view returns (byte) {
        return reg.verifyTransfer(_from, _to, _value, _data);
    }

    function _canForceTransfer(address origin) internal view returns (bool) {
        return reg.checkRegulator(origin);
    }

    function canTransferFrom(address _from, address _to, uint256 _value, bytes calldata _data) external view returns (byte) {
        return reg.verifyTransfer(_from, _to, _value, _data);
    }

    function canTransfer(address _to, uint256 _value, bytes calldata _data) external view returns (byte) {
        return reg.verifyTransfer(msg.sender, _to, _value, _data);
    }
    
}

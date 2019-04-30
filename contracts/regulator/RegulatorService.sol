pragma solidity ^0.5.2;

import "openzeppelin-solidity/contracts/token/ERC20/IERC20.sol";
import "./IRegulatorService.sol";
import "../kyc/IStoreKYC.sol";
import "../identities/IAddressIdentities.sol";
import "./RegulatorRole.sol";

contract RegulatorService is RegulatorRole, IRegulatorService {

    IERC20 public token;
    IAddressIdentities public investors;
    IStoreKYC public kyc;

    bool public frozen;

    constructor(address _token, address _investors, address _kyc) public {
        token = IERC20(_token);
        investors = IAddressIdentities(_investors);
        kyc = IStoreKYC(_kyc);
    }

    function freeze(bool status) external onlyRegulator {
        frozen = status;
    }

    function checkRegulator(address origin) external view returns (bool) {
        return isRegulator(origin);
    }

      
    /**
     * @dev Verify if tokens can be transferred with transfer restrctions (that's not currently implemented)
     * @param _from The address to transfer from.
     * @param _to The address to transfer to.
     * @param _value The amount to be transferred.
     * @param _data Extra data to use when checking transfer permissions (not implemented)
     */

    function verifyTransfer(address _from, address _to, uint256 /* _value */, bytes calldata /* _data */) external view returns (byte) {

        return hex"11";
    }

}

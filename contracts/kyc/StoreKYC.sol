pragma solidity ^0.5.2;

import "./IStoreKYC.sol";
import "./KYCAdminRole.sol";

contract StoreKYC is KYCAdminRole, IStoreKYC {

    mapping(bytes32 => KYCData) private _kycData;

    function getKYC(bytes32 id) external view returns (uint32 countryCode, bool accredited) {
        KYCData memory _data = _kycData[id];
        return (_data.countryCode, _data.accredited);
    }

    function putKYC(bytes32 id, uint32 countryCode, bool accredited) external onlyKYCAdmin {
        _kycData[id] = KYCData(countryCode, accredited);
        emit ChangedKYC(id);
    }

    function removeKYC(bytes32 id) external onlyKYCAdmin {
        delete _kycData[id];
        emit ChangedKYC(id);
    }
}

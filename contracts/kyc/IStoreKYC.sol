pragma solidity ^0.5.2;

interface IStoreKYC {

    // KYC Data struct. Note that any KYC non-private information can be stored here
    struct KYCData {
        uint32 countryCode;
        bool accredited;
    }

    function getKYC(bytes32 id) external view returns  (uint32 countryCode, bool accredited);

    function putKYC(bytes32 id, uint32 countryCode, bool accredited) external;

    function removeKYC(bytes32 id) external;

    event ChangedKYC(bytes32 indexed id);

}

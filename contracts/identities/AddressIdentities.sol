pragma solidity ^0.5.2;

import "./IAddressIdentities.sol";
import "./IdentityAssignerRole.sol";

contract AddressIdentities is IdentityAssignerRole, IAddressIdentities {

    mapping(address => bytes32) private _investors;

    uint256 public investorCount;

    function getInvestor(address addr) external view returns (bytes32) {
        return _investors[addr];
    }

    function putInvestor(address addr, bytes32 id) external onlyIdentityAssigner {
        require(id != 0x0);
        require(addr != address(0x0));
        _investors[addr] = id;

        emit ChangedInvestor(addr, id);
    }

    function removeInvestor(address addr) external onlyIdentityAssigner {
        bytes32 id = _investors[addr];
        if (id == 0x0) {
            return;
        }
        delete _investors[addr];
        
        emit ChangedInvestor(addr, id);
    }
}

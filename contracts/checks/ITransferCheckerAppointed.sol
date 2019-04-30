pragma solidity ^0.5.2;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "./TransferChecker.sol";
import "./ITransferChecker.sol";
import "../regulator/IRegulatorService.sol";
import "./RegServAppointerRole.sol";

// Layer on top of transfer-checker, to manage appointer role separately.
interface ITransferCheckerAppointed {

    // Update the regulator service by calling this function with the address of it.
    function changeRegServ(address newRegServ) external;

}

pragma solidity ^0.5.2;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "./TransferChecker.sol";
import "./ITransferChecker.sol";
import "../regulator/IRegulatorService.sol";
import "./RegServAppointerRole.sol";
import "./ITransferCheckerAppointed.sol";

contract TransferCheckerAppointed is ERC20, TransferChecker, RegServAppointerRole, ITransferCheckerAppointed {

    function changeRegServ(address newRegServ) external onlyRegServAppointer {
        reg = IRegulatorService(newRegServ);
    }

}

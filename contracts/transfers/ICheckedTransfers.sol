pragma solidity ^0.5.2;

// ERC1594 part: Transfer Processing
interface ICheckedTransfers {

    function transferWithData(address _to, uint256 _value, bytes calldata _data) external;
    function transferFromWithData(address _from, address _to, uint256 _value, bytes calldata _data) external;

    event ForceTransfer(address indexed from, address indexed to, uint256 value, address regulator);
}

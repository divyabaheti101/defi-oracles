// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "./IOracle.sol";

contract Consumer {
    IOracle public oracle;

    constructor(address oracleAddress) {
        oracle = IOracle(oracleAddress);
    }

    function fetchData() external view {
        bytes32 key = keccak256(abi.encodePacked("ETH/USD"));
        (bool result, uint date, uint payload) = oracle.getData(key);
        require(result, "no data");
        require(date >= block.timestamp - 2 minutes , "stale data");
    }
}
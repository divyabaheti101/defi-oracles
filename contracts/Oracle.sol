// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

contract Oracle {
    struct Data {
        uint256 date;
        uint256 payload;
    }
    address public admin;
    mapping(address => bool) public isReporter;
    mapping(bytes32 => Data) public data;

    constructor(address _admin) {
        admin = _admin;
    }

    function updateReporter(address reporter, bool status) external {
        require(msg.sender == admin, "only admin");
        isReporter[reporter] = status;
    }

    function updateData(
        bytes32 key,
        uint256 payload
    ) external {
        require(isReporter[msg.sender], "only reporter");
        data[key] = Data({date: block.timestamp, payload: payload});
    }

    function getData(bytes32 key) external view returns (bool result, uint date, uint payload) {
        if(data[key].date == 0) {
            return (false, 0, 0);
        }
        return (true, data[key].date, data[key].payload);
    }
}
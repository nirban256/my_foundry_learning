// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/Fundme.sol";

contract FundFundMe is Script {
    function fundFundMe(address mostRecentDeployed) public {
        uint256 SEND_VALUE = 0.1 ether;
        vm.startBroadcast();
        FundMe(payable(mostRecentDeployed)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();
        console.log("Funded fund me with %s", SEND_VALUE);
    }

    function run() external {
        address mostRecentDeployment = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        fundFundMe(mostRecentDeployment);
    }
}

contract WithdrawFundMe is Script {}

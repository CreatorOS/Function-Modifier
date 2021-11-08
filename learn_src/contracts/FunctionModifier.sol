// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract FunctionModifier {
    address public owner;

    constructor() {
        // Set the transaction sender as the owner of the contract.
        owner = msg.sender;
    }

}

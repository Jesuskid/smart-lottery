// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";

contract Lottery {
    address payable[] public players;
    uint256 public usdEntryFee;

    AggregatorV3Interface internal ethUsdPriceFeed;

    constructor(address priceFeedAddress) public {
        usdEntryFee = 50 * (10**18);
        ethUsdPriceFeed = AggregatorV3Interface(priceFeedAddress);
    }

    //This function enters the user(address) into the lottery when a transaction is made
    function enter() public payable {
        //msg.sender gets the address of the user that made the transaction
        players.push(msg.sender);
    }

    //
    function getEntreanceFee() public view returns (uint256) {
        (, int256 price, , , ) = ethUsdPriceFeed.latestRoundData(); //18 decimals
        //converting price from usd to eth
        uint256 adjustedPrice = uint256(price) * 10**10; //18 decimals
        uint256 costToEnter = (usdEntryFee * 10**18) / adjustedPrice;
        return costToEnter;
    }

    function start() public {}

    function end() public {}
}

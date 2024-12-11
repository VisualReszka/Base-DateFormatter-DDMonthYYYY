// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/DateFormatter.sol";

contract DateFormatterTest is Test {
    DateFormatter private formatter;

    function setUp() public {
        formatter = new DateFormatter();
    }

    function testFormatDateRegularYear() public view {
        uint timestamp = 1672531199; // December 31, 2022
        string memory formattedDate = formatter.formatDate(timestamp);
        assertEq(formattedDate, "31 December 2022");
    }

    function testFormatDateLeapYear() public view {
        uint timestamp = 1582934400; // February 29, 2020
        string memory formattedDate = formatter.formatDate(timestamp);
        assertEq(formattedDate, "29 February 2020");
    }

    function testFormatDateOriginYear() public view {
        uint timestamp = 0; // January 1, 1970
        string memory formattedDate = formatter.formatDate(timestamp);
        assertEq(formattedDate, "1 January 1970");
    }

    function testFormatDateStartOfYear() public view {
        uint timestamp = 1609459200; // January 1, 2021
        string memory formattedDate = formatter.formatDate(timestamp);
        assertEq(formattedDate, "1 January 2021");
    }

    function testFormatDateEndOfYear() public view {
        uint timestamp = 1672531199; // December 31, 2022
        string memory formattedDate = formatter.formatDate(timestamp);
        assertEq(formattedDate, "31 December 2022");
    }

    function testFormatDateLeapYearFuture1() public view{
        uint timestamp = 1767225600; // January 01, 2026
        string memory formattedDate = formatter.formatDate(timestamp);
        assertEq(formattedDate, "1 January 2026");
    }

    function testFormatDateLeapYearFuture() public view {
        uint timestamp = 1709164800; // February 29, 2024
        string memory formattedDate = formatter.formatDate(timestamp);
        assertEq(formattedDate, "29 February 2024");
    }

}

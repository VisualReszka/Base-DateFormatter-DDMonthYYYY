// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
                                      
/// /////////////////////////////////////// //\\ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
/// ///                                /// //  \\ \\\                              \\\
/// ///      Behind the Visuals       /// //    \\ \\\               ART           \\\
/// ///            • • •             /// //      \\ \\\               &            \\\
/// ///    visualreszka.base.eth    /// //        \\ \\\             CODE          \\\
/// ///                            /// //          \\ \\\                          \\\
/// ///////////////////////////////// //            \\ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


/// @title DateFormatter
/// @notice A contract for formatting timestamps into human-readable dates in DD Month YYYY format

contract DateFormatter {
    uint constant DAY_IN_SECONDS = 86400;
    uint16 constant ORIGIN_YEAR = 1970;
    uint constant MAX_TIMESTAMP = 2524608000; // 2050-01-01 00:00:00

    /// @dev List of month names in English, stored in memory for efficient retrieval
    string[12] internal MONTH_NAMES = [
        "January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December"
    ];

    /// @notice Converts a timestamp into a formatted date string
    /// @param timestamp The Unix timestamp to format
    /// @return The formatted date string in "DD Month YYYY" format
    function formatDate(uint timestamp) public view returns (string memory) {
        require(timestamp <= MAX_TIMESTAMP, "Timestamp too large");
        (uint16 year, uint8 month, uint8 day) = _timestampToDate(timestamp);

        // Validate month value to prevent out-of-bounds access
        require(month >= 1 && month <= 12, "Invalid month value");

        return string(
            abi.encodePacked(
                _uintToString(day), // Day of the month
                " ",
                MONTH_NAMES[month - 1], // Month name
                " ",
                _uintToString(year) // Year
            )
        );
    }

    /// @notice Converts a Unix timestamp to its corresponding year, month, and day
    /// @param timestamp The Unix timestamp
    /// @return year The year (e.g., 2024)
    /// @return month The month (1 = January, ..., 12 = December)
    /// @return day The day of the month (1–31)
    function _timestampToDate(uint timestamp) internal pure returns (uint16 year, uint8 month, uint8 day) {
        uint secondsAccountedFor = 0;
        uint buf;

        year = ORIGIN_YEAR;

        // Determine the year
        while (secondsAccountedFor <= timestamp) {
            buf = isLeapYear(year) ? 366 : 365;
            buf *= DAY_IN_SECONDS;
            if (secondsAccountedFor + buf > timestamp) {
                break;
            }
            secondsAccountedFor += buf;
            year++;
        }

        // Determine the month
        uint8[12] memory daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        if (isLeapYear(year)) {
            daysInMonth[1] = 29; // February has 29 days in a leap year
        }

        for (month = 1; month <= 12; month++) {
            buf = daysInMonth[month - 1] * DAY_IN_SECONDS;
            if (secondsAccountedFor + buf > timestamp) {
                break;
            }
            secondsAccountedFor += buf;
        }

        // Determine the day
        day = uint8((timestamp - secondsAccountedFor) / DAY_IN_SECONDS) + 1;
    }

    /// @notice Checks if a year is a leap year
    /// @param year The year to check
    /// @return True if the year is a leap year, otherwise false
    function isLeapYear(uint16 year) internal pure returns (bool) {
        return (year % 4 == 0) && (year % 100 != 0 || year % 400 == 0);
    }

    /// @notice Converts an unsigned integer to its string representation
    /// @param value The unsigned integer to convert
    /// @return The string representation of the integer
    function _uintToString(uint value) internal pure returns (string memory) {
        if (value == 0) return "0";

        uint temp = value;
        uint digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }

        bytes memory buffer = new bytes(digits);
        temp = value;
        while (digits > 0) {
            buffer[--digits] = bytes1(uint8(48 + temp % 10)); // ASCII '0' is 48
            temp /= 10;
        }

        return string(buffer);
    }
}
/// ///////////////  ///////////////  ///////////////  ///////////////  ///////////////  
/// ビジュアルの裏側                                               visualreszka.base.eth
/// \\\\\\\\\\\\\\\  \\\\\\\\\\\\\\\  \\\\\\\\\\\\\\\  \\\\\\\\\\\\\\\  \\\\\\\\\\\\\\\
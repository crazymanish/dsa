//
//  ViewController+Challenge60.swift
//  HashTable
//
//  Created by Manish Rathi on 30/03/2022.
//

import Foundation
/*
 1805. Number of Different Integers in a String
 https://leetcode.com/problems/number-of-different-integers-in-a-string/
 You are given a string word that consists of digits and lowercase English letters.
 You will replace every non-digit character with a space. For example, "a123bc34d8ef34" will become " 123  34 8  34". Notice that you are left with some integers that are separated by at least one space: "123", "34", "8", and "34".
 Return the number of different integers after performing the replacement operations on word.
 Two integers are considered different if their decimal representations without any leading zeros are different.

 Example 1:
 Input: word = "a123bc34d8ef34"
 Output: 3
 Explanation: The three different integers are "123", "34", and "8". Notice that "34" is only counted once.

 Example 2:
 Input: word = "leet1234code234"
 Output: 2

 Example 3:
 Input: word = "a1b01c001"
 Output: 1
 Explanation: The three integers "1", "01", and "001" all represent the same integer because
 the leading zeros are ignored when comparing their decimal values.
 */

extension ViewController {
    func solve60() {
        print("Setting up Challenge60 input!")

        let input = "a123bc34d8ef34"
        print("Input: \(input)")
        let output = Solution().numDifferentIntegers(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func numDifferentIntegers(_ word: String) -> Int {
        var resultSet : Set<String> = []

        let digits: [Character] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        var currentDigit = ""

        for char in word {
            if digits.contains(char) {
                currentDigit += String(char)
            } else if currentDigit.count > 0 {
                resultSet.insert(currentDigit.trimLeadingZeros)
                currentDigit = ""
            }
        }

        if currentDigit.count > 0 {
            resultSet.insert(currentDigit.trimLeadingZeros)
        }

        return resultSet.count
    }
}

private extension String {
    var trimLeadingZeros: String {
        var currentString = self

        while currentString.first == "0" {
            currentString.removeFirst()
        }

        return currentString
    }
}

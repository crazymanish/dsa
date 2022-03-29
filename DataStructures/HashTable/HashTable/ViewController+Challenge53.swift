//
//  ViewController+Challenge53.swift
//  HashTable
//
//  Created by Manish Rathi on 29/03/2022.
//

import Foundation
/*
 1796. Second Largest Digit in a String
 https://leetcode.com/problems/second-largest-digit-in-a-string/
 Given an alphanumeric string s, return the second largest numerical digit that appears in s, or -1 if it does not exist.
 An alphanumeric string is a string consisting of lowercase English letters and digits.

 Example 1:
 Input: s = "dfa12321afd"
 Output: 2
 Explanation: The digits that appear in s are [1, 2, 3]. The second largest digit is 2.

 Example 2:
 Input: s = "abc1111"
 Output: -1
 Explanation: The digits that appear in s are [1]. There is no second largest digit.
 */

extension ViewController {
    func solve53() {
        print("Setting up Challenge53 input!")

        let input = "dfa12321afd"
        print("Input: \(input)")
        let output = Solution().secondHighest(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func secondHighest(_ s: String) -> Int {
        var hashMap: [Character : Bool] = [:]

        for char in s { hashMap[char] = true }

        var largestDigit = -1

        for digit in 0...9 {
            let char = Character(String(digit))
            if hashMap[char] != nil {
                largestDigit = max(largestDigit, digit)
            }
        }

        var secondLargestDigit = -1

        if largestDigit != -1 {
            for digit in 0...9 {
                let char = Character(String(digit))
                if hashMap[char] != nil, digit < largestDigit  {
                    secondLargestDigit = max(secondLargestDigit, digit)
                }
            }
        }

        return secondLargestDigit
    }
}

//
//  ViewController+Challenge45.swift
//  HashTable
//
//  Created by Manish Rathi on 28/03/2022.
//

import Foundation
/*
 409. Longest Palindrome
 https://leetcode.com/problems/longest-palindrome/
 Given a string s which consists of lowercase or uppercase letters, return the length of the longest palindrome that can be built with those letters.
 Letters are case sensitive, for example, "Aa" is not considered a palindrome here.

 Example 1:
 Input: s = "abccccdd"
 Output: 7
 Explanation:
 One longest palindrome that can be built is "dccaccd", whose length is 7.

 Example 2:
 Input: s = "a"
 Output: 1

 Example 3:
 Input: s = "bb"
 Output: 2
 */

extension ViewController {
    func solve45() {
        print("Setting up Challenge45 input!")

        let input = "abccccdd"
        print("Input: \(input)")
        let output = Solution().longestPalindrome(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func longestPalindrome(_ s: String) -> Int {
        var hashMap: [Character : Int] = [:]

        for char in s {
            let hashMapValue = hashMap[char] ?? 0
            hashMap[char] = hashMapValue + 1
        }

        var output = 0
        var isOddValueFound = false

        for (_, value) in hashMap {
            if isOddValueFound == false && value % 2 != 0 { isOddValueFound = true }

            output += (value / 2) * 2
        }

        if isOddValueFound { output += 1 }

        return output
    }
}

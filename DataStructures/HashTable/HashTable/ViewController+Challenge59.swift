//
//  ViewController+Challenge59.swift
//  HashTable
//
//  Created by Manish Rathi on 30/03/2022.
//

import Foundation
/*
 290. Word Pattern
 https://leetcode.com/problems/word-pattern/
 Given a pattern and a string s, find if s follows the same pattern.
 Here follow means a full match, such that there is a bijection between a letter in pattern and a non-empty word in s.

 Example 1:
 Input: pattern = "abba", s = "dog cat cat dog"
 Output: true

 Example 2:
 Input: pattern = "abba", s = "dog cat cat fish"
 Output: false

 Example 3:
 Input: pattern = "aaaa", s = "dog cat cat dog"
 Output: false
 */

extension ViewController {
    func solve59() {
        print("Setting up Challenge59 input!")

        let input = "dog cat cat dog"
        print("Input: \(input)")
        let output = Solution().wordPattern("abba", input)
        print("Output: \(output)")
    }
}

private class Solution {
    func wordPattern(_ pattern: String, _ s: String) -> Bool {
        let patternArray = Array(pattern)
        let sArray = s.components(separatedBy: " ")

        guard patternArray.count == sArray.count else { return false }

        var patternHashMap: [Character: String] = [:]
        var sHashMap: [String: Character] = [:]

        for (index, patternChar) in patternArray.enumerated() {
            let sString = sArray[index]

            if patternHashMap[patternChar] == nil && sHashMap[sString] == nil {
                patternHashMap[patternChar] = sString
                sHashMap[sString] = patternChar
            } else if (patternHashMap[patternChar] != sString) || (sHashMap[sString] != patternChar) {
                return false
            }
        }

        return true
    }
}

//
//  ViewController+Challenge4.swift
//  HashTable
//
//  Created by Manish Rathi on 25/03/2022.
//

import Foundation
/*
 1684. Count the Number of Consistent Strings
 https://leetcode.com/problems/count-the-number-of-consistent-strings/
 You are given a string allowed consisting of distinct characters and an array of strings words. A string is consistent if all characters in the string appear in the string allowed.
 Return the number of consistent strings in the array words.

 Example 1:
 Input: allowed = "ab", words = ["ad","bd","aaab","baa","badab"]
 Output: 2
 Explanation: Strings "aaab" and "baa" are consistent since they only contain characters 'a' and 'b'.

 Example 2:
 Input: allowed = "abc", words = ["a","b","c","ab","ac","bc","abc"]
 Output: 7
 Explanation: All strings are consistent.

 Example 3:
 Input: allowed = "cad", words = ["cc","acd","b","ba","bac","bad","ac","d"]
 Output: 4
 Explanation: Strings "cc", "acd", "ac", and "d" are consistent.
 */

extension ViewController {
    func solve4() {
        print("Setting up Challenge4 input!")

        let allowed = "ab"
        let words = ["ad","bd","aaab","baa","badab"]
        print("Input: \(allowed), \(words)")
        let output = Solution().countConsistentStrings(allowed, words)
        print("Output: \(output)")
    }
}

private class Solution {
    func countConsistentStrings(_ allowed: String, _ words: [String]) -> Int {
        typealias CharIsExistMap = [Character : Bool]
        var hashMap: CharIsExistMap = [:]

        for char in allowed {
            hashMap[char] = true
        }

        var output = 0
        for word in words {
            var isInConsistentCharFound = false
            for char in word {
                if hashMap[char] == nil {
                    isInConsistentCharFound = true
                    break
                }
            }

            if isInConsistentCharFound == false { output += 1 }
        }

        return output
    }
}

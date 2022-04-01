//
//  ViewController+Challenge69.swift
//  HashTable
//
//  Created by Manish Rathi on 01/04/2022.
//

import Foundation
/*
 1347. Minimum Number of Steps to Make Two Strings Anagram
 https://leetcode.com/problems/minimum-number-of-steps-to-make-two-strings-anagram/
 You are given two strings of the same length s and t. In one step you can choose any character of t and replace it with another character.
 Return the minimum number of steps to make t an anagram of s.
 An Anagram of a string is a string that contains the same characters with a different (or the same) ordering.

 Example 1:
 Input: s = "bab", t = "aba"
 Output: 1
 Explanation: Replace the first 'a' in t with b, t = "bba" which is anagram of s.

 Example 2:
 Input: s = "leetcode", t = "practice"
 Output: 5
 Explanation: Replace 'p', 'r', 'a', 'i' and 'c' from t with proper characters to make t anagram of s.

 Example 3:
 Input: s = "anagram", t = "mangaar"
 Output: 0
 Explanation: "anagram" and "mangaar" are anagrams.
 */

extension ViewController {
    func solve69() {
        print("Setting up Challenge69 input!")

        let input = "bab"
        print("Input: \(input)")
        let output = Solution().minSteps(input, "aba")
        print("Output: \(output)")
    }
}

private class Solution {
    func minSteps(_ s: String, _ t: String) -> Int {
        let hashMapS = hashMap(s)
        let hashMapT = hashMap(t)

        var output = 0
        for (key, valueS) in hashMapS {
            let valueT = hashMapT[key] ?? 0
            let minStepsRequired = max(valueS - valueT, 0)

            output += minStepsRequired
        }

        return output
    }

    private func hashMap(_ string: String) -> [Character : Int] {
        typealias Frequency = Int
        var hashMap: [Character : Frequency] = [:]

        for char in string {
            let hashMapValue = hashMap[char] ?? 0
            hashMap[char] = hashMapValue + 1
        }

        return hashMap
    }
}

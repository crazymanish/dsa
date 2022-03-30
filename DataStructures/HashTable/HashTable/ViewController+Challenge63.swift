//
//  ViewController+Challenge63.swift
//  HashTable
//
//  Created by Manish Rathi on 30/03/2022.
//

import Foundation
/*
 859. Buddy Strings
 https://leetcode.com/problems/buddy-strings/
 Given two strings s and goal, return true if you can swap two letters in s so the result is equal to goal, otherwise, return false.
 Swapping letters is defined as taking two indices i and j (0-indexed) such that i != j and swapping the characters at s[i] and s[j].
 For example, swapping at indices 0 and 2 in "abcd" results in "cbad".

 Example 1:
 Input: s = "ab", goal = "ba"
 Output: true
 Explanation: You can swap s[0] = 'a' and s[1] = 'b' to get "ba", which is equal to goal.

 Example 2:
 Input: s = "ab", goal = "ab"
 Output: false
 Explanation: The only letters you can swap are s[0] = 'a' and s[1] = 'b', which results in "ba" != goal.

 Example 3:
 Input: s = "aa", goal = "aa"
 Output: true
 Explanation: You can swap s[0] = 'a' and s[1] = 'a' to get "aa", which is equal to goal.
 */

extension ViewController {
    func solve63() {
        print("Setting up Challenge63 input!")

        let input = "ab"
        print("Input: \(input)")
        let output = Solution().buddyStrings(input, "ba")
        print("Output: \(output)")
    }
}

private class Solution {
    func buddyStrings(_ s1: String, _ s2: String) -> Bool {
        guard s1.count == s2.count else { return false }

        if s1 == s2 {
            return Set(s1).count < s1.count
        } else {
            var diffs: [Int] = []
            let array1 = Array(s1)
            let array2 = Array(s2)

            for index in 0..<array1.count {
                if array1[index] != array2[index] {
                    diffs.append(index)
                }
            }

            guard diffs.count == 2 else { return false }

            let i = diffs[0]
            let j = diffs[1]

            return array1[i] == array2[j] && array1[j] == array2[i]
        }
    }
}

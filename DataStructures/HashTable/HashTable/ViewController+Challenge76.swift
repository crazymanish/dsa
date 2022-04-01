//
//  ViewController+Challenge76.swift
//  HashTable
//
//  Created by Manish Rathi on 01/04/2022.
//

import Foundation
/*
 2186. Minimum Number of Steps to Make Two Strings Anagram II
 https://leetcode.com/problems/minimum-number-of-steps-to-make-two-strings-anagram-ii/
 You are given two strings s and t. In one step, you can append any character to either s or t.
 Return the minimum number of steps to make s and t anagrams of each other.
 An anagram of a string is a string that contains the same characters with a different (or the same) ordering.

 Example 1:
 Input: s = "leetcode", t = "coats"
 Output: 7
 Explanation:
 - In 2 steps, we can append the letters in "as" onto s = "leetcode", forming s = "leetcodeas".
 - In 5 steps, we can append the letters in "leede" onto t = "coats", forming t = "coatsleede".
 "leetcodeas" and "coatsleede" are now anagrams of each other.
 We used a total of 2 + 5 = 7 steps.
 It can be shown that there is no way to make them anagrams of each other with less than 7 steps.

 Example 2:
 Input: s = "night", t = "thing"
 Output: 0
 Explanation: The given strings are already anagrams of each other. Thus, we do not need any further steps.
 */

extension ViewController {
    func solve76() {
        print("Setting up Challenge76 input!")

        let input = "leetcode"
        print("Input: \(input)")
        let output = Solution().minSteps(input, "coats")
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

        for (key, valueT) in hashMapT {
            let valueS = hashMapS[key] ?? 0
            let minStepsRequired = max(valueT - valueS, 0)

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

//
//  ViewController+Challenge9.swift
//  HashTable
//
//  Created by Manish Rathi on 26/03/2022.
//

import Foundation
/*
 1941. Check if All Characters Have Equal Number of Occurrences
 https://leetcode.com/problems/check-if-all-characters-have-equal-number-of-occurrences/
 Given a string s, return true if s is a good string, or false otherwise.
 A string s is good if all the characters that appear in s have the same number of occurrences (i.e., the same frequency).

 Example 1:
 Input: s = "abacbc"
 Output: true
 Explanation: The characters that appear in s are 'a', 'b', and 'c'. All characters occur 2 times in s.

 Example 2:
 Input: s = "aaabb"
 Output: false
 Explanation: The characters that appear in s are 'a' and 'b'.
 'a' occurs 3 times while 'b' occurs 2 times, which is not the same number of times.
 */

extension ViewController {
    func solve9() {
        print("Setting up Challenge9 input!")

        let input = "abacbc"
        print("Input: \(input)")
        let output = Solution().areOccurrencesEqual(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func areOccurrencesEqual(_ s: String) -> Bool {
        typealias CharFrequency = [Character : Int]
        var hashMap: CharFrequency = [:]

        for char in s {
            if let currentFrequency = hashMap[char] {
                hashMap[char] = currentFrequency + 1
            } else {
                hashMap[char] = 1
            }
        }

        var isEqualFrequency = true
        let firstCharFrequency = hashMap[s.first!]
        for (_, value) in hashMap {
            if value != firstCharFrequency {
                isEqualFrequency = false
                break
            }
        }

        return isEqualFrequency
    }
}

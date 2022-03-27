//
//  ViewController+Challenge34.swift
//  HashTable
//
//  Created by Manish Rathi on 27/03/2022.
//

import Foundation
/*
 1897. Redistribute Characters to Make All Strings Equal
 https://leetcode.com/problems/redistribute-characters-to-make-all-strings-equal/
 You are given an array of strings words (0-indexed).
 In one operation, pick two distinct indices i and j, where words[i] is a non-empty string, and move any character from words[i] to any position in words[j].
 Return true if you can make every string in words equal using any number of operations, and false otherwise.

 Example 1:
 Input: words = ["abc","aabc","bc"]
 Output: true
 Explanation: Move the first 'a' in words[1] to the front of words[2],
 to make words[1] = "abc" and words[2] = "abc".
 All the strings are now equal to "abc", so return true.

 Example 2:
 Input: words = ["ab","a"]
 Output: false
 Explanation: It is impossible to make all the strings equal using the operation.
 */

extension ViewController {
    func solve34() {
        print("Setting up Challenge34 input!")

        let input = ["abc","aabc","bc"]
        print("Input: \(input)")
        let output = Solution().makeEqual(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func makeEqual(_ words: [String]) -> Bool {
        var hashMap: [Character : Int] = [:]

        for word in words {
            for char in word {
                let hashMapValue = hashMap[char] ?? 0
                hashMap[char] = hashMapValue + 1
            }
        }

        let wordsCount = words.count

        if wordsCount == 1 { return true }

        var canMakeEqual = true
        for (_, value) in hashMap {
            if value % wordsCount != 0 {
                canMakeEqual = false
                break
            }
        }

        return canMakeEqual
    }
}

//
//  ViewController+Challenge71.swift
//  HashTable
//
//  Created by Manish Rathi on 01/04/2022.
//

import Foundation
/*
 890. Find and Replace Pattern
 https://leetcode.com/problems/find-and-replace-pattern/
 Given a list of strings words and a string pattern, return a list of words[i] that match pattern. You may return the answer in any order.
 A word matches the pattern if there exists a permutation of letters p so that after replacing every letter x in the pattern with p(x), we get the desired word.
 Recall that a permutation of letters is a bijection from letters to letters: every letter maps to another letter, and no two letters map to the same letter.

 Example 1:
 Input: words = ["abc","deq","mee","aqq","dkd","ccc"], pattern = "abb"
 Output: ["mee","aqq"]
 Explanation: "mee" matches the pattern because there is a permutation {a -> m, b -> e, ...}.
 "ccc" does not match the pattern because {a -> c, b -> c, ...} is not a permutation, since a and b map to the same letter.

 Example 2:
 Input: words = ["a","b","c"], pattern = "a"
 Output: ["a","b","c"]
 */

extension ViewController {
    func solve71() {
        print("Setting up Challenge71 input!")

        let input = ["abc","deq","mee","aqq","dkd","ccc"]
        print("Input: \(input)")
        let output = Solution().findAndReplacePattern(input, "abb")
        print("Output: \(output)")
    }
}

private class Solution {
    func findAndReplacePattern(_ words: [String], _ pattern: String) -> [String] {
        var output: [String] = []

        for word in words {
            if isIsomorphic(word, pattern) {
                output.append(word)
            }
        }

        return output
    }

    private func isIsomorphic(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else { return false }

        var sHashMap: [Character:Character] = [:]
        var tHashMap: [Character:Character] = [:]

        let sArray = Array(s)
        let tArray = Array(t)

        for (index, sChar) in sArray.enumerated() {
            let tChar = tArray[index]

            if sHashMap[sChar] == nil && tHashMap[tChar] == nil {
                sHashMap[sChar] = tChar
                tHashMap[tChar] = sChar
            } else if (sHashMap[sChar] != tChar) || (tHashMap[tChar] != sChar) {
                return false
            }
        }

        return true
    }
}

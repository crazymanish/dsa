//
//  ViewController+Challenge27.swift
//  HashTable
//
//  Created by Manish Rathi on 27/03/2022.
//

import Foundation
/*
 884. Uncommon Words from Two Sentences
 https://leetcode.com/problems/uncommon-words-from-two-sentences/
 A sentence is a string of single-space separated words where each word consists only of lowercase letters.
 A word is uncommon if it appears exactly once in one of the sentences, and does not appear in the other sentence.
 Given two sentences s1 and s2, return a list of all the uncommon words. You may return the answer in any order.

 Example 1:
 Input: s1 = "this apple is sweet", s2 = "this apple is sour"
 Output: ["sweet","sour"]

 Example 2:
 Input: s1 = "apple apple", s2 = "banana"
 Output: ["banana"]
 */

extension ViewController {
    func solve27() {
        print("Setting up Challenge27 input!")

        let input = "this apple is sweet"
        print("Input: \(input)")
        let output = Solution().uncommonFromSentences(input, "this apple is sour")
        print("Output: \(output)")
    }
}

private class Solution {
    func uncommonFromSentences(_ s1: String, _ s2: String) -> [String] {
        var hashMap: [String : Int] = [:]

        let s1Words = s1.components(separatedBy: " ")
        let s2Words = s2.components(separatedBy: " ")

        for word in s1Words {
            let hashMapValue = hashMap[word] ?? 0
            hashMap[word] = hashMapValue + 1
        }

        for word in s2Words {
            let hashMapValue = hashMap[word] ?? 0
            hashMap[word] = hashMapValue + 1
        }

        var output: [String] = []
        for (key, value) in hashMap {
            if value == 1 { output.append(key) }
        }

        return output
    }
}

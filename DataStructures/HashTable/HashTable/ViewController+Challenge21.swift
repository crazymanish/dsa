//
//  ViewController+Challenge21.swift
//  HashTable
//
//  Created by Manish Rathi on 27/03/2022.
//

import Foundation
/*
 1160. Find Words That Can Be Formed by Characters
 https://leetcode.com/problems/find-words-that-can-be-formed-by-characters/
 You are given an array of strings words and a string chars.
 A string is good if it can be formed by characters from chars (each character can only be used once).
 Return the sum of lengths of all good strings in words.

 Example 1:
 Input: words = ["cat","bt","hat","tree"], chars = "atach"
 Output: 6
 Explanation: The strings that can be formed are "cat" and "hat" so the answer is 3 + 3 = 6.

 Example 2:
 Input: words = ["hello","world","leetcode"], chars = "welldonehoneyr"
 Output: 10
 Explanation: The strings that can be formed are "hello" and "world" so the answer is 5 + 5 = 10.
 */

extension ViewController {
    func solve21() {
        print("Setting up Challenge21 input!")

        let input = ["cat","bt","hat","tree"]
        print("Input: \(input)")
        let output = Solution().countCharacters(input, "atach")
        print("Output: \(output)")
    }
}

private class Solution {
    func countCharacters(_ words: [String], _ chars: String) -> Int {
        var charsHashMap: [Character : Int] = [:]

        for char in chars {
            if let hashMapValue = charsHashMap[char] {
                charsHashMap[char] = hashMapValue + 1
            } else {
                charsHashMap[char] = 1
            }
        }

        var outputWordsLength = 0

        for word in words {
            var hashMap = charsHashMap
            var canFormWord = true
            for char in word {
                if let hashMapValue = hashMap[char] {
                    if hashMapValue == 0 {
                        canFormWord = false
                        break
                    } else {
                        hashMap[char] = hashMapValue - 1
                    }
                } else {
                    canFormWord = false
                    break
                }
            }

            if canFormWord { outputWordsLength += word.count }
        }

        return outputWordsLength
    }
}

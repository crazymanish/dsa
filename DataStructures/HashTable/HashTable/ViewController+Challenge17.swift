//
//  ViewController+Challenge17.swift
//  HashTable
//
//  Created by Manish Rathi on 26/03/2022.
//

import Foundation
/*
 1935. Maximum Number of Words You Can Type
 https://leetcode.com/problems/maximum-number-of-words-you-can-type/
 There is a malfunctioning keyboard where some letter keys do not work. All other keys on the keyboard work properly.
 Given a string text of words separated by a single space (no leading or trailing spaces) and a string brokenLetters of all distinct letter keys that are broken, return the number of words in text you can fully type using this keyboard.

 Example 1:
 Input: text = "hello world", brokenLetters = "ad"
 Output: 1
 Explanation: We cannot type "world" because the 'd' key is broken.

 Example 2:
 Input: text = "leet code", brokenLetters = "lt"
 Output: 1
 Explanation: We cannot type "leet" because the 'l' and 't' keys are broken.

 Example 3:
 Input: text = "leet code", brokenLetters = "e"
 Output: 0
 Explanation: We cannot type either word because the 'e' key is broken.
 */

extension ViewController {
    func solve17() {
        print("Setting up Challenge17 input!")

        let input = "hello world"
        print("Input: \(input)")
        let output = Solution().canBeTypedWords(input, "ad")
        print("Output: \(output)")
    }
}

private class Solution {
    func canBeTypedWords(_ text: String, _ brokenLetters: String) -> Int {
        var brokenCharHashMap: [Character : Bool] = [:]
        for char in brokenLetters { brokenCharHashMap[char] = true }

        var canBeTypedWords = 0

        let words = text.components(separatedBy: " ")
        for word in words {
            var canTypeCurrentWord = true
            for char in word {
                if brokenCharHashMap[char] != nil {
                    canTypeCurrentWord = false
                    break
                }
            }

            if canTypeCurrentWord { canBeTypedWords += 1 }

        }

        return canBeTypedWords
    }
}

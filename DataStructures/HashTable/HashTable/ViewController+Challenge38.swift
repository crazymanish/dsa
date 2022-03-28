//
//  ViewController+Challenge38.swift
//  HashTable
//
//  Created by Manish Rathi on 28/03/2022.
//

import Foundation
/*
 748. Shortest Completing Word
 https://leetcode.com/problems/shortest-completing-word/
 Given a string licensePlate and an array of strings words, find the shortest completing word in words.
 A completing word is a word that contains all the letters in licensePlate. Ignore numbers and spaces in licensePlate, and treat letters as case insensitive. If a letter appears more than once in licensePlate, then it must appear in the word the same number of times or more.
 For example, if licensePlate = "aBc 12c", then it contains letters 'a', 'b' (ignoring case), and 'c' twice. Possible completing words are "abccdef", "caaacab", and "cbca".
 Return the shortest completing word in words. It is guaranteed an answer exists. If there are multiple shortest completing words, return the first one that occurs in words.

 Example 1:
 Input: licensePlate = "1s3 PSt", words = ["step","steps","stripe","stepple"]
 Output: "steps"
 Explanation: licensePlate contains letters 's', 'p', 's' (ignoring case), and 't'.
 "step" contains 't' and 'p', but only contains 1 's'.
 "steps" contains 't', 'p', and both 's' characters.
 "stripe" is missing an 's'.
 "stepple" is missing an 's'.
 Since "steps" is the only word containing all the letters, that is the answer.

 Example 2:
 Input: licensePlate = "1s3 456", words = ["looks","pest","stew","show"]
 Output: "pest"
 Explanation: licensePlate only contains the letter 's'. All the words contain 's', but among these "pest", "stew", and "show" are shortest. The answer is "pest" because it is the word that appears earliest of the 3.
 */

extension ViewController {
    func solve38() {
        print("Setting up Challenge38 input!")

        let input = ["step","steps","stripe","stepple"]
        print("Input: \(input)")
        let output = Solution().shortestCompletingWord("1s3 PSt", input)
        print("Output: \(output)")
    }
}

private class Solution {
    func shortestCompletingWord(_ licensePlate: String, _ words: [String]) -> String {
        var hashMap: [Character : Int] = [:]

        for scalar in licensePlate.lowercased().unicodeScalars {
            let value = scalar.value

            if (value >= 97 && value <= 122) { // to find a-z
                let char = Character(scalar)
                let hashMapValue = hashMap[char] ?? 0
                hashMap[char] = hashMapValue + 1
            }
        }

        var shortestWord: String? = nil

        for word in words {
            var licensePlateHashMap = hashMap

            for char in word {
                if let hashMapValue = licensePlateHashMap[char] {
                    licensePlateHashMap[char] = hashMapValue - 1
                }
            }

            var canCompleteWord = true
            for (_, value) in licensePlateHashMap {
                if value > 0 {
                    canCompleteWord = false
                    break
                }
            }

            if canCompleteWord {
                if let previousShortestWord = shortestWord {
                    if word.count < previousShortestWord.count { shortestWord = word }
                } else {
                    shortestWord = word
                }
            }
        }

        return shortestWord!
    }
}

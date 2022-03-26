//
//  ViewController+Challenge5.swift
//  HashTable
//
//  Created by Manish Rathi on 26/03/2022.
//

import Foundation
/*
 1832. Check if the Sentence Is Pangram
 https://leetcode.com/problems/check-if-the-sentence-is-pangram/
 A pangram is a sentence where every letter of the English alphabet appears at least once.
 Given a string sentence containing only lowercase English letters, return true if sentence is a pangram, or false otherwise.

 Example 1:
 Input: sentence = "thequickbrownfoxjumpsoverthelazydog"
 Output: true
 Explanation: sentence contains at least one of every letter of the English alphabet.

 Example 2:
 Input: sentence = "leetcode"
 Output: false
 */

extension ViewController {
    func solve5() {
        print("Setting up Challenge5 input!")

        let input = "thequickbrownfoxjumpsoverthelazydog"
        print("Input: \(input)")
        let output = Solution().checkIfPangram(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func checkIfPangram(_ sentence: String) -> Bool {
        var hashMap: [Character : Bool] = [:]
        var hashMapLettersCount = 0

        for character in sentence {
            // No need to loop, if we already found all chars
            if hashMapLettersCount == 26 { break }

            if hashMap[character] == nil {
                hashMap[character] = true
                hashMapLettersCount += 1
            }
        }

        return hashMapLettersCount == 26
    }
}

//
//  ViewController+Challenge64.swift
//  HashTable
//
//  Created by Manish Rathi on 30/03/2022.
//

import Foundation
/*
 1002. Find Common Characters
 https://leetcode.com/problems/find-common-characters/
 Given a string array words, return an array of all characters that show up in all strings within the words (including duplicates). You may return the answer in any order.

 Example 1:
 Input: words = ["bella","label","roller"]
 Output: ["e","l","l"]

 Example 2:
 Input: words = ["cool","lock","cook"]
 Output: ["c","o"]
 */

extension ViewController {
    func solve64() {
        print("Setting up Challenge64 input!")

        let input = ["bella","label","roller"]
        print("Input: \(input)")
        let output = Solution().commonChars(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func commonChars(_ words: [String]) -> [String] {
        if words.isEmpty { return [] }

        var result = words[0]

        for word in words {
            var currentWord = word
            var newResult = ""

            for char in result {
                if let index = currentWord.firstIndex(of: char) {
                    newResult.append(char)
                    currentWord.remove(at: index)
                }
            }

            result = newResult
        }

        return result.map { String($0) }
    }
}

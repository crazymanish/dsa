//
//  ViewController+Challenge56.swift
//  HashTable
//
//  Created by Manish Rathi on 29/03/2022.
//

import Foundation
/*
 819. Most Common Word
 https://leetcode.com/problems/most-common-word/
 Given a string paragraph and a string array of the banned words banned, return the most frequent word that is not banned. It is guaranteed there is at least one word that is not banned, and that the answer is unique.
 The words in paragraph are case-insensitive and the answer should be returned in lowercase.

 Example 1:
 Input: paragraph = "Bob hit a ball, the hit BALL flew far after it was hit.", banned = ["hit"]
 Output: "ball"
 Explanation:
 "hit" occurs 3 times, but it is a banned word.
 "ball" occurs twice (and no other word does), so it is the most frequent non-banned word in the paragraph.
 Note that words in the paragraph are not case sensitive,
 that punctuation is ignored (even if adjacent to words, such as "ball,"),
 and that "hit" isn't the answer even though it occurs more because it is banned.

 Example 2:
 Input: paragraph = "a.", banned = []
 Output: "a"
 */

extension ViewController {
    func solve56() {
        print("Setting up Challenge56 input!")

        let input = "Bob hit a ball, the hit BALL flew far after it was hit."
        print("Input: \(input)")
        let output = Solution().mostCommonWord(input, ["hit"])
        print("Output: \(output)")
    }
}

private class Solution {
    func mostCommonWord(_ paragraph: String, _ banned: [String]) -> String {
        var text = paragraph.lowercased()
        text = text.replacingOccurrences(
            of: "[!?',;.]",
            with: " ",
            options: [.regularExpression])
        let words = text.components(separatedBy: " ")

        var hashMap: [String : Int] = [:]
        for word in words {
            let hashMapValue = hashMap[word] ?? 0
            hashMap[word] = hashMapValue + 1
        }

        hashMap[""] = -1

        for word in banned {
            hashMap[word] = -1
        }

        var mostCommonWord = ""
        var mostCommonWordTimes = Int.min

        for (key, value) in hashMap {
            if value > mostCommonWordTimes {
                mostCommonWordTimes = value
                mostCommonWord = key
            }
        }

        return mostCommonWord
    }
}

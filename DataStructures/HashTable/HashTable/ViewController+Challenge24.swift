//
//  ViewController+Challenge24.swift
//  HashTable
//
//  Created by Manish Rathi on 27/03/2022.
//

import Foundation
/*
 2068. Check Whether Two Strings are Almost Equivalent
 https://leetcode.com/problems/check-whether-two-strings-are-almost-equivalent/
 Two strings word1 and word2 are considered almost equivalent if the differences between the frequencies of each letter from 'a' to 'z' between word1 and word2 is at most 3.

 Given two strings word1 and word2, each of length n, return true if word1 and word2 are almost equivalent, or false otherwise.
 The frequency of a letter x is the number of times it occurs in the string.

 Example 1:
 Input: word1 = "aaaa", word2 = "bccb"
 Output: false
 Explanation: There are 4 'a's in "aaaa" but 0 'a's in "bccb".
 The difference is 4, which is more than the allowed 3.

 Example 2:
 Input: word1 = "abcdeef", word2 = "abaaacc"
 Output: true
 Explanation: The differences between the frequencies of each letter in word1 and word2 are at most 3:
 - 'a' appears 1 time in word1 and 4 times in word2. The difference is 3.
 - 'b' appears 1 time in word1 and 1 time in word2. The difference is 0.
 - 'c' appears 1 time in word1 and 2 times in word2. The difference is 1.
 - 'd' appears 1 time in word1 and 0 times in word2. The difference is 1.
 - 'e' appears 2 times in word1 and 0 times in word2. The difference is 2.
 - 'f' appears 1 time in word1 and 0 times in word2. The difference is 1.

 Example 3:
 Input: word1 = "cccddabba", word2 = "babababab"
 Output: true
 Explanation: The differences between the frequencies of each letter in word1 and word2 are at most 3:
 - 'a' appears 2 times in word1 and 4 times in word2. The difference is 2.
 - 'b' appears 2 times in word1 and 5 times in word2. The difference is 3.
 - 'c' appears 3 times in word1 and 0 times in word2. The difference is 3.
 - 'd' appears 2 times in word1 and 0 times in word2. The difference is 2.
 */

extension ViewController {
    func solve24() {
        print("Setting up Challenge24 input!")

        let input = "abcdeef"
        print("Input: \(input)")
        let output = Solution().checkAlmostEquivalent(input, "abaaacc")
        print("Output: \(output)")
    }
}

private class Solution {
    func checkAlmostEquivalent(_ word1: String, _ word2: String) -> Bool {
        let word1HashMap = addIntoHashMap(word1)
        let word2HashMap = addIntoHashMap(word2)

        var isEquivalent = true
        isEquivalent = isAlmostEquivalent(word1HashMap, word2HashMap)

        if isEquivalent {
            isEquivalent = isAlmostEquivalent(word2HashMap, word1HashMap)
        }

        return isEquivalent
    }

    private func addIntoHashMap(_ word: String) -> [Character : Int] {
        var hashMap: [Character : Int] = [:]

        for char in word {
            if let hashMapValue = hashMap[char] {
                hashMap[char] = hashMapValue + 1
            } else {
                hashMap[char] = 1
            }
        }

        return hashMap
    }

    private func isAlmostEquivalent(_ hash1: [Character : Int], _ hash2: [Character : Int]) -> Bool {
        var isAlmostEquivalent = true

        for (key, value) in hash1 {
            let hash2Value = hash2[key] ?? 0

            if abs(hash2Value - value) > 3 {
                isAlmostEquivalent = false
                break
            }
        }

        return isAlmostEquivalent
    }
}

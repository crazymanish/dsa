//
//  ViewController+Challenge31.swift
//  HashTable
//
//  Created by Manish Rathi on 27/03/2022.
//

import Foundation
/*
 242. Valid Anagram
 https://leetcode.com/problems/valid-anagram/
 Given two strings s and t, return true if t is an anagram of s, and false otherwise.
 An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.

 Example 1:
 Input: s = "anagram", t = "nagaram"
 Output: true

 Example 2:
 Input: s = "rat", t = "car"
 Output: false
 */

extension ViewController {
    func solve31() {
        print("Setting up Challenge31 input!")

        let input = "anagram"
        print("Input: \(input)")
        let output = Solution().isAnagram(input, "nagaram")
        print("Output: \(output)")
    }
}

private class Solution {
    func isAnagram(_ s: String, _ t: String) -> Bool {
        let hashMapS = hashMap(s)
        let hashMapT = hashMap(t)

        var isHashAnagram = true
        isHashAnagram = isAnagram(hashMapS, hashMapT)

        if isHashAnagram {
            isHashAnagram = isAnagram(hashMapT, hashMapS)
        }

        return isHashAnagram
    }

    private func isAnagram(
        _ hashMapS: [Character : Int],
        _ hashMapT: [Character : Int]) -> Bool {
        var isAnagram = true

        for (key, value) in hashMapT {
            let sValue = hashMapS[key] ?? -1
            if sValue != value {
                isAnagram = false
                break
            }
        }

        return isAnagram
    }

    private func hashMap(_ text: String) -> [Character : Int] {
        var hashMap: [Character : Int] = [:]

        for char in text {
            let hashMapValue = hashMap[char] ?? 0
            hashMap[char] = hashMapValue + 1
        }

        return hashMap
    }
}

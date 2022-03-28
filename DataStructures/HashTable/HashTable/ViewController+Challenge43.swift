//
//  ViewController+Challenge43.swift
//  HashTable
//
//  Created by Manish Rathi on 28/03/2022.
//

import Foundation
/*
 383. Ransom Note
 https://leetcode.com/problems/ransom-note/
 Given two strings ransomNote and magazine, return true if ransomNote can be constructed from magazine and false otherwise.
 Each letter in magazine can only be used once in ransomNote.

 Example 1:
 Input: ransomNote = "a", magazine = "b"
 Output: false

 Example 2:
 Input: ransomNote = "aa", magazine = "ab"
 Output: false

 Example 3:
 Input: ransomNote = "aa", magazine = "aab"
 Output: true
 */

extension ViewController {
    func solve43() {
        print("Setting up Challenge43 input!")

        let input = "aa"
        print("Input: \(input)")
        let output = Solution().canConstruct(input, "aab")
        print("Output: \(output)")
    }
}

private class Solution {
    func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
        let hashMapRansomNote = hashMap(ransomNote)
        let hashMapMagazine = hashMap(magazine)

        return canConstruct(hashMapRansomNote, hashMapMagazine)
    }

    private func canConstruct(
        _ hashMapRansomNote: [Character : Int],
        _ hashMapMagazine: [Character : Int]) -> Bool {
        var canConstruct = true

        for (key, value) in hashMapRansomNote {
            let sValue = hashMapMagazine[key] ?? -1
            if value > sValue  {
                canConstruct = false
                break
            }
        }

        return canConstruct
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

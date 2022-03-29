//
//  ViewController+Challenge57.swift
//  HashTable
//
//  Created by Manish Rathi on 29/03/2022.
//

import Foundation
/*
 205. Isomorphic Strings
 https://leetcode.com/problems/isomorphic-strings/
 Given two strings s and t, determine if they are isomorphic.
 Two strings s and t are isomorphic if the characters in s can be replaced to get t.
 All occurrences of a character must be replaced with another character while preserving the order of characters. No two characters may map to the same character, but a character may map to itself.

 Example 1:
 Input: s = "egg", t = "add"
 Output: true

 Example 2:
 Input: s = "foo", t = "bar"
 Output: false

 Example 3:
 Input: s = "paper", t = "title"
 Output: true
 */

extension ViewController {
    func solve57() {
        print("Setting up Challenge57 input!")

        let input = "paper"
        print("Input: \(input)")
        let output = Solution().isIsomorphic(input, "title")
        print("Output: \(output)")
    }
}

private class Solution {
    func isIsomorphic(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else { return false }

        var sHashMap: [Character:Character] = [:]
        var tHashMap: [Character:Character] = [:]

        let sArray = Array(s)
        let tArray = Array(t)

        for (index, sChar) in sArray.enumerated() {
            let tChar = tArray[index]

            if sHashMap[sChar] == nil && tHashMap[tChar] == nil {
                sHashMap[sChar] = tChar
                tHashMap[tChar] = sChar
            } else if (sHashMap[sChar] != tChar) || (tHashMap[tChar] != sChar) {
                return false
            }
        }

        return true
    }
}

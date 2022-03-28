//
//  ViewController+Challenge41.swift
//  HashTable
//
//  Created by Manish Rathi on 28/03/2022.
//

import Foundation
/*
 387. First Unique Character in a String
 https://leetcode.com/problems/first-unique-character-in-a-string/
 Given a string s, find the first non-repeating character in it and return its index. If it does not exist, return -1.

 Example 1:
 Input: s = "leetcode"
 Output: 0

 Example 2:
 Input: s = "loveleetcode"
 Output: 2

 Example 3:
 Input: s = "aabb"
 Output: -1
 */

extension ViewController {
    func solve41() {
        print("Setting up Challenge41 input!")

        let input = "loveleetcode"
        print("Input: \(input)")
        let output = Solution().firstUniqChar(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func firstUniqChar(_ s: String) -> Int {
        var hashMap: [Character : Bool] = [:]

        for char in s {
            if hashMap[char] == nil {
                hashMap[char] = true
            } else {
                hashMap[char] = false
            }
        }

        var uniqueCharIndex = -1
        var currentIndex = 0
        for char in s {
            if hashMap[char]! == true {
                uniqueCharIndex = currentIndex
                break
            }
            currentIndex += 1
        }

        return uniqueCharIndex
    }
}

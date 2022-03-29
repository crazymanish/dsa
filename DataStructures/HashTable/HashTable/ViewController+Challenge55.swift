//
//  ViewController+Challenge55.swift
//  HashTable
//
//  Created by Manish Rathi on 29/03/2022.
//

import Foundation
/*
 1790. Check if One String Swap Can Make Strings Equal
 https://leetcode.com/problems/check-if-one-string-swap-can-make-strings-equal/
 You are given two strings s1 and s2 of equal length. A string swap is an operation where you choose two indices in a string (not necessarily different) and swap the characters at these indices.

 Return true if it is possible to make both strings equal by performing at most one string swap on exactly one of the strings. Otherwise, return false.

 Example 1:
 Input: s1 = "bank", s2 = "kanb"
 Output: true
 Explanation: For example, swap the first character with the last character of s2 to make "bank".

 Example 2:
 Input: s1 = "attack", s2 = "defend"
 Output: false
 Explanation: It is impossible to make them equal with one string swap.

 Example 3:
 Input: s1 = "kelb", s2 = "kelb"
 Output: true
 Explanation: The two strings are already equal, so no string swap operation is required.
 */

extension ViewController {
    func solve55() {
        print("Setting up Challenge55 input!")

        let input = "bank"
        print("Input: \(input)")
        let output = Solution().areAlmostEqual(input, "kanb")
        print("Output: \(output)")
    }
}

private class Solution {
    func areAlmostEqual(_ s1: String, _ s2: String) -> Bool {
        let hashMapS1 = hashMap(s1)
        let hashMapS2 = hashMap(s2)

        var areAlmostEqual = true

        var hashMapDiff: [Character : Character] = [:]
        for (key, value1) in hashMapS1 {
            let value2 = hashMapS2[key]!

            if value1 != value2 {
                if hashMapDiff[value1] != nil {
                    areAlmostEqual = false
                    break
                } else {
                    hashMapDiff[value1] = value2
                }
            }
        }

        if areAlmostEqual {
            let diffKeys = Array(hashMapDiff.keys)

            if diffKeys.count == 0 { areAlmostEqual = true }
            else if diffKeys.count == 2 {
                let firstKey = diffKeys[0]
                let secondKey = diffKeys[1]

                let firstValue = hashMapDiff[firstKey]!
                let secondValue = hashMapDiff[secondKey]!

                if firstKey == secondValue && firstValue == secondKey {
                    areAlmostEqual = true
                } else {
                    areAlmostEqual = false
                }
            } else {
                areAlmostEqual = false
            }
        }

        return areAlmostEqual
    }

    private func hashMap(_ string: String) -> [Int : Character] {
        var hashMap: [Int : Character] = [:]

        for index in 0..<string.count {
            hashMap[index] = string[index]
        }

        return hashMap
    }
}

private extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

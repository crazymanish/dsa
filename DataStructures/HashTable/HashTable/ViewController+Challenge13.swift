//
//  ViewController+Challenge13.swift
//  HashTable
//
//  Created by Manish Rathi on 26/03/2022.
//

import Foundation
/*
 2053. Kth Distinct String in an Array
 https://leetcode.com/problems/kth-distinct-string-in-an-array/
 A distinct string is a string that is present only once in an array.
 Given an array of strings arr, and an integer k, return the kth distinct string present in arr. If there are fewer than k distinct strings, return an empty string "".
 Note that the strings are considered in the order in which they appear in the array.

 Example 1:
 Input: arr = ["d","b","c","b","c","a"], k = 2
 Output: "a"
 Explanation:
 The only distinct strings in arr are "d" and "a".
 "d" appears 1st, so it is the 1st distinct string.
 "a" appears 2nd, so it is the 2nd distinct string.
 Since k == 2, "a" is returned.

 Example 2:
 Input: arr = ["aaa","aa","a"], k = 1
 Output: "aaa"
 Explanation:
 All strings in arr are distinct, so the 1st string "aaa" is returned.

 Example 3:
 Input: arr = ["a","b","a"], k = 3
 Output: ""
 Explanation:
 The only distinct string is "b". Since there are fewer than 3 distinct strings, we return an empty string "".
 */

extension ViewController {
    func solve13() {
        print("Setting up Challenge13 input!")

        let input = ["d","b","c","b","c","a"]
        print("Input: \(input)")
        let output = Solution().kthDistinct(input, 2)
        print("Output: \(output)")
    }
}

private class Solution {
    func kthDistinct(_ arr: [String], _ k: Int) -> String {
        var hashMap: [String : Bool] = [:]
        var distinctElements: [String] = []

        for element in arr {
            if hashMap[element] == nil {
                hashMap[element] = true
                distinctElements.append(element)
            } else {
                if let index = distinctElements.firstIndex(of:element) {
                    distinctElements.remove(at: index)
                }
            }
        }

        if distinctElements.count >= k {
            return distinctElements[k-1]
        }

        return ""
    }
}

//
//  ViewController+Challenge15.swift
//  HashTable
//
//  Created by Manish Rathi on 26/03/2022.
//

import Foundation
/*
 1207. Unique Number of Occurrences
 https://leetcode.com/problems/unique-number-of-occurrences/
 Given an array of integers arr, return true if the number of occurrences of each value in the array is unique, or false otherwise.

 Example 1:
 Input: arr = [1,2,2,1,1,3]
 Output: true
 Explanation: The value 1 has 3 occurrences, 2 has 2 and 3 has 1. No two values have the same number of occurrences.

 Example 2:
 Input: arr = [1,2]
 Output: false

 Example 3:
 Input: arr = [-3,0,1,-3,1,1,1,-3,10,0]
 Output: true
 */

extension ViewController {
    func solve15() {
        print("Setting up Challenge15 input!")

        let input = [1,2,2,1,1,3]
        print("Input: \(input)")
        let output = Solution().uniqueOccurrences(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func uniqueOccurrences(_ arr: [Int]) -> Bool {
        var hashMap: [Int : Int] = [:]

        for number in arr {
            if let hashMapOccurrence = hashMap[number] {
                hashMap[number] = hashMapOccurrence + 1
            } else {
                hashMap[number] = 1
            }
        }

        var isAllUniqueOccurrences = true

        var uniqueHashMap: [Int : Bool] = [:]
        for (_, value) in hashMap {
            if uniqueHashMap[value] == nil {
                uniqueHashMap[value] = true
            } else {
                isAllUniqueOccurrences = false
                break
            }
        }


        return isAllUniqueOccurrences
    }
}

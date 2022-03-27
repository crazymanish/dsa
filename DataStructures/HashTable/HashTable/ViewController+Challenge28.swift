//
//  ViewController+Challenge28.swift
//  HashTable
//
//  Created by Manish Rathi on 27/03/2022.
//

import Foundation
/*
 1394. Find Lucky Integer in an Array
 https://leetcode.com/problems/find-lucky-integer-in-an-array/
 Given an array of integers arr, a lucky integer is an integer that has a frequency in the array equal to its value.
 Return the largest lucky integer in the array. If there is no lucky integer return -1.

 Example 1:
 Input: arr = [2,2,3,4]
 Output: 2
 Explanation: The only lucky number in the array is 2 because frequency[2] == 2.

 Example 2:
 Input: arr = [1,2,2,3,3,3]
 Output: 3
 Explanation: 1, 2 and 3 are all lucky numbers, return the largest of them.

 Example 3:
 Input: arr = [2,2,2,3,3]
 Output: -1
 Explanation: There are no lucky numbers in the array.
 */

extension ViewController {
    func solve28() {
        print("Setting up Challenge28 input!")

        let input = [1,2,2,3,3,3]
        print("Input: \(input)")
        let output = Solution().findLucky(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func findLucky(_ nums: [Int]) -> Int {
        var hashMap: [Int : Int] = [:]

        for num in nums {
            let hashMapValue = hashMap[num] ?? 0
            hashMap[num] = hashMapValue + 1
        }

        var luckyNumber = -1
        for (key, value) in hashMap {
            if key == value { luckyNumber = max(luckyNumber, value) }
        }

        return luckyNumber
    }
}

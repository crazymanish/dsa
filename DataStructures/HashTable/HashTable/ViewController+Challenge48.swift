//
//  ViewController+Challenge48.swift
//  HashTable
//
//  Created by Manish Rathi on 28/03/2022.
//

import Foundation
/*
 594. Longest Harmonious Subsequence
 https://leetcode.com/problems/longest-harmonious-subsequence/
 We define a harmonious array as an array where the difference between its maximum value and its minimum value is exactly 1.
 Given an integer array nums, return the length of its longest harmonious subsequence among all its possible subsequences.
 A subsequence of array is a sequence that can be derived from the array by deleting some or no elements without changing the order of the remaining elements.

 Example 1:
 Input: nums = [1,3,2,2,5,2,3,7]
 Output: 5
 Explanation: The longest harmonious subsequence is [3,2,2,2,3].

 Example 2:
 Input: nums = [1,2,3,4]
 Output: 2

 Example 3:
 Input: nums = [1,1,1,1]
 Output: 0
 */

extension ViewController {
    func solve48() {
        print("Setting up Challenge48 input!")

        let input = [1,3,2,2,5,2,3,7]
        print("Input: \(input)")
        let output = Solution().findLHS(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func findLHS(_ nums: [Int]) -> Int {
        var hashMap: [Int : Int] = [:]

        for num in nums {
            let hashMapValue = hashMap[num] ?? 0
            hashMap[num] = hashMapValue + 1
        }

        var outputResult = 0

        for (key, value) in hashMap {
            if let plusOneValue = hashMap[key+1] {
                let result = value + plusOneValue
                outputResult = max(outputResult, result)
            }
        }

        return outputResult
    }
}

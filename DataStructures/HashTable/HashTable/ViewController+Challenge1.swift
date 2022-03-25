//
//  ViewController+Challenge1.swift
//  HashTable
//
//  Created by Manish Rathi on 25/03/2022.
//

import Foundation
/*
 1512. Number of Good Pairs
 https://leetcode.com/problems/number-of-good-pairs/
 Given an array of integers nums, return the number of good pairs.
 A pair (i, j) is called good if nums[i] == nums[j] and i < j.

 Example 1:
 Input: nums = [1,2,3,1,1,3]
 Output: 4
 Explanation: There are 4 good pairs (0,3), (0,4), (3,4), (2,5) 0-indexed.

 Example 2:
 Input: nums = [1,1,1,1]
 Output: 6
 Explanation: Each pair in the array are good.

 Example 3:
 Input: nums = [1,2,3]
 Output: 0
 */

extension ViewController {
    func solve1() {
        print("Setting up Challenge1 input!")

        let input = [1,2,3,1,1,3]
        print("Input: \(input)")
        let output = Solution().numIdenticalPairs(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func numIdenticalPairs(_ nums: [Int]) -> Int {
        typealias ValueTimesMap = [Int : Int]
        var hashMap: ValueTimesMap = [:]

        for num in nums {
            if let existingHashMapValue = hashMap[num] {
                hashMap[num] = existingHashMapValue + 1
            } else {
                hashMap[num] = 1
            }
        }

        var maximumPairs = 0
        for (_, value) in hashMap {
            maximumPairs += value * (value - 1)
        }

        return maximumPairs / 2
    }
}

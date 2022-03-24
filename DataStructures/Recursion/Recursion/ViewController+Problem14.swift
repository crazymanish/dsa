//
//  ViewController+Problem14.swift
//  Recursion
//
//  Created by Manish Rathi on 24/03/2022.
//

import Foundation
/*
 1. Two Sum
 https://leetcode.com/problems/two-sum/
 Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.
 You may assume that each input would have exactly one solution, and you may not use the same element twice.
 You can return the answer in any order.

 Example 1:
 Input: nums = [2,7,11,15], target = 9
 Output: [0,1]
 Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].

 Example 2:
 Input: nums = [3,2,4], target = 6
 Output: [1,2]

 Example 3:
 Input: nums = [3,3], target = 6
 Output: [0,1]
 */

extension ViewController {
    func solve14() {
        print("Setting up Problem14 input!")

        let input = [2,7,11,15]
        print("Input: \(input)")
        let output = Solution().twoSum(input, 9)
        print("Output: \(output)")
    }
}

private class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var hashMap: [Int : Int] = [:]
        var output: [Int] = []

        var index = 0
        for num in nums {
            if let remainingTargetIndex = hashMap[target-num] {
                output.append(remainingTargetIndex)
                output.append(index)
                break
            }

            hashMap[num] = index
            index += 1
        }

        return output
    }
}

//
//  ViewController+Challenge11.swift
//  HashTable
//
//  Created by Manish Rathi on 26/03/2022.
//

import Foundation
/*
 961. N-Repeated Element in Size 2N Array
 https://leetcode.com/problems/n-repeated-element-in-size-2n-array/
 You are given an integer array nums with the following properties:
 nums.length == 2 * n.
 nums contains n + 1 unique elements.
 Exactly one element of nums is repeated n times.
 Return the element that is repeated n times.

 Example 1:
 Input: nums = [1,2,3,3]
 Output: 3

 Example 2:
 Input: nums = [2,1,2,5,3,2]
 Output: 2

 Example 3:
 Input: nums = [5,1,5,2,5,3,5,4]
 Output: 5
 */

extension ViewController {
    func solve11() {
        print("Setting up Challenge11 input!")

        let input = [1,2,3,3]
        print("Input: \(input)")
        let output = Solution().repeatedNTimes(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func repeatedNTimes(_ nums: [Int]) -> Int {
        var hashMap: [Int : Int] = [:]
        let expectedRepeatedCount = nums.count / 2

        var outputRepeatedNumber = 0

        for num in nums {
            if let hashMapCount = hashMap[num] {
                let newHashMapCount = hashMapCount - 1

                if newHashMapCount == 1 {
                    outputRepeatedNumber = num
                    break
                }

                hashMap[num] = newHashMapCount
            } else {
                hashMap[num] = expectedRepeatedCount
            }
        }

        return outputRepeatedNumber
    }
}

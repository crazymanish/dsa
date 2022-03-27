//
//  ViewController+Challenge29.swift
//  HashTable
//
//  Created by Manish Rathi on 27/03/2022.
//

import Foundation
/*
 169. Majority Element
 https://leetcode.com/problems/majority-element/
 Given an array nums of size n, return the majority element.
 The majority element is the element that appears more than ⌊n / 2⌋ times. You may assume that the majority element always exists in the array.

 Example 1:
 Input: nums = [3,2,3]
 Output: 3

 Example 2:
 Input: nums = [2,2,1,1,1,2,2]
 Output: 2
 */

extension ViewController {
    func solve29() {
        print("Setting up Challenge29 input!")

        let input = [2,2,1,1,1,2,2]
        print("Input: \(input)")
        let output = Solution().majorityElement(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func majorityElement(_ nums: [Int]) -> Int {
        var hashMap: [Int : Int] = [:]
        let target = nums.count / 2

        for num in nums {
            let hashMapValue = hashMap[num] ?? 0
            hashMap[num] = hashMapValue + 1
        }

        var output = -1
        for (key, value) in hashMap {
            if value > target {
                output = key
                break
            }
        }

        return output
    }
}

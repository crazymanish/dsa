//
//  ViewController+Challenge32.swift
//  HashTable
//
//  Created by Manish Rathi on 27/03/2022.
//

import Foundation
/*
 217. Contains Duplicate
 https://leetcode.com/problems/contains-duplicate/
 Given an integer array nums, return true if any value appears at least twice in the array, and return false if every element is distinct.

 Example 1:
 Input: nums = [1,2,3,1]
 Output: true

 Example 2:
 Input: nums = [1,2,3,4]
 Output: false

 Example 3:
 Input: nums = [1,1,1,3,3,4,3,2,4,2]
 Output: true
 */

extension ViewController {
    func solve32() {
        print("Setting up Challenge32 input!")

        let input = [1,1,1,3,3,4,3,2,4,2]
        print("Input: \(input)")
        let output = Solution().containsDuplicate(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func containsDuplicate(_ nums: [Int]) -> Bool {
        var hashMap: [Int: Bool] = [:]

        var containsDuplicate = false

        for num in nums {
            if hashMap[num] == nil {
                hashMap[num] = true
            } else {
                containsDuplicate = true
                break
            }
        }

        return containsDuplicate
    }
}

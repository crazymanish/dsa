//
//  ViewController+Challenge73.swift
//  HashTable
//
//  Created by Manish Rathi on 01/04/2022.
//

import Foundation
/*
 442. Find All Duplicates in an Array
 https://leetcode.com/problems/find-all-duplicates-in-an-array/
 Given an integer array nums of length n where all the integers of nums are in the range [1, n] and each integer appears once or twice, return an array of all the integers that appears twice.
 You must write an algorithm that runs in O(n) time and uses only constant extra space.

 Example 1:
 Input: nums = [4,3,2,7,8,2,3,1]
 Output: [2,3]

 Example 2:
 Input: nums = [1,1,2]
 Output: [1]

 Example 3:
 Input: nums = [1]
 Output: []
 */

extension ViewController {
    func solve73() {
        print("Setting up Challenge73 input!")

        let input = [4,3,2,7,8,2,3,1]
        print("Input: \(input)")
        let output = Solution().findDuplicates(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func findDuplicates(_ nums: [Int]) -> [Int] {
        var hashMap: [Int : Bool] = [:]
        var output: [Int] = []

        for num in nums {
            if hashMap[num] == nil {
                hashMap[num] = true
            } else {
                output.append(num)
            }
        }

        return output
    }
}

//
//  ViewController+Challenge10.swift
//  HashTable
//
//  Created by Manish Rathi on 26/03/2022.
//

import Foundation
/*
 1748. Sum of Unique Elements
 https://leetcode.com/problems/sum-of-unique-elements/
 You are given an integer array nums. The unique elements of an array are the elements that appear exactly once in the array.
 Return the sum of all the unique elements of nums.

 Example 1:
 Input: nums = [1,2,3,2]
 Output: 4
 Explanation: The unique elements are [1,3], and the sum is 4.

 Example 2:
 Input: nums = [1,1,1,1,1]
 Output: 0
 Explanation: There are no unique elements, and the sum is 0.

 Example 3:
 Input: nums = [1,2,3,4,5]
 Output: 15
 Explanation: The unique elements are [1,2,3,4,5], and the sum is 15.
 */

extension ViewController {
    func solve10() {
        print("Setting up Challenge10 input!")

        let input = [1,2,3,2]
        print("Input: \(input)")
        let output = Solution().sumOfUnique(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func sumOfUnique(_ nums: [Int]) -> Int {
        var hashMap: [Int : Bool] = [:]
        var uniqueElementsSum = 0

        for num in nums {
            if let hashMapValue = hashMap[num] {
                if hashMapValue {
                    hashMap[num] = false
                    uniqueElementsSum -= num
                }
            } else {
                hashMap[num] = true
                uniqueElementsSum += num
            }
        }

        return uniqueElementsSum
    }
}

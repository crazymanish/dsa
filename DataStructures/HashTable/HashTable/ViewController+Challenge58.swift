//
//  ViewController+Challenge58.swift
//  HashTable
//
//  Created by Manish Rathi on 29/03/2022.
//

import Foundation
/*
 645. Set Mismatch
 https://leetcode.com/problems/set-mismatch/
 You have a set of integers s, which originally contains all the numbers from 1 to n. Unfortunately, due to some error, one of the numbers in s got duplicated to another number in the set, which results in repetition of one number and loss of another number.
 You are given an integer array nums representing the data status of this set after the error.
 Find the number that occurs twice and the number that is missing and return them in the form of an array.

 Example 1:
 Input: nums = [1,2,2,4]
 Output: [2,3]

 Example 2:
 Input: nums = [1,1]
 Output: [1,2]
 */

extension ViewController {
    func solve58() {
        print("Setting up Challenge58 input!")

        let input = [1,2,2,4]
        print("Input: \(input)")
        let output = Solution().findErrorNums(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func findErrorNums(_ nums: [Int]) -> [Int] {
        var nums = nums
        var duplicate = 0
        var missing = 0

        for n in nums {
            if nums[n - 1] < 0 {
                duplicate = n
            } else {
                nums[n - 1] = -1
            }
        }

        for i in 0..<nums.count {
            if nums[i] > 0 {
                missing = i + 1
                break
            }
        }

        return [duplicate, missing]
    }
}

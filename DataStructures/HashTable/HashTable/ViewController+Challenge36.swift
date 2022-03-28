//
//  ViewController+Challenge36.swift
//  HashTable
//
//  Created by Manish Rathi on 28/03/2022.
//

import Foundation
/*
 268. Missing Number
 https://leetcode.com/problems/missing-number/
 Given an array nums containing n distinct numbers in the range [0, n], return the only number in the range that is missing from the array.

 Example 1:
 Input: nums = [3,0,1]
 Output: 2
 Explanation: n = 3 since there are 3 numbers, so all numbers are in the range [0,3]. 2 is the missing number in the range since it does not appear in nums.

 Example 2:
 Input: nums = [0,1]
 Output: 2
 Explanation: n = 2 since there are 2 numbers, so all numbers are in the range [0,2]. 2 is the missing number in the range since it does not appear in nums.

 Example 3:
 Input: nums = [9,6,4,2,3,5,7,0,1]
 Output: 8
 Explanation: n = 9 since there are 9 numbers, so all numbers are in the range [0,9]. 8 is the missing number in the range since it does not appear in nums.
 */

extension ViewController {
    func solve36() {
        print("Setting up Challenge36 input!")

        let input = [9,6,4,2,3,5,7,0,1]
        print("Input: \(input)")
        let output = Solution().missingNumber(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func missingNumber(_ numbers: [Int]) -> Int {
        let sortedNumbers = numbers.sorted()

        var missingNumber = -1

        var index = 0
        for number in sortedNumbers {
            if number != index {
                missingNumber = index
                break
            }

            index += 1
        }

        if missingNumber == -1 {  return numbers.count }

        return missingNumber
    }
}

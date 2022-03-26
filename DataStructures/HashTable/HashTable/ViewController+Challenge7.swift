//
//  ViewController+Challenge7.swift
//  HashTable
//
//  Created by Manish Rathi on 26/03/2022.
//

import Foundation
/*
 2206. Divide Array Into Equal Pairs
 https://leetcode.com/problems/divide-array-into-equal-pairs/
 You are given an integer array nums consisting of 2 * n integers.
 You need to divide nums into n pairs such that:
 Each element belongs to exactly one pair.
 The elements present in a pair are equal.
 Return true if nums can be divided into n pairs, otherwise return false.

 Example 1:
 Input: nums = [3,2,3,2,2,2]
 Output: true
 Explanation:
 There are 6 elements in nums, so they should be divided into 6 / 2 = 3 pairs.
 If nums is divided into the pairs (2, 2), (3, 3), and (2, 2), it will satisfy all the conditions.

 Example 2:
 Input: nums = [1,2,3,4]
 Output: false
 Explanation:
 There is no way to divide nums into 4 / 2 = 2 pairs such that the pairs satisfy every condition.
 */

extension ViewController {
    func solve7() {
        print("Setting up Challenge7 input!")

        let input = [3,2,3,2,2,2]
        print("Input: \(input)")
        let output = Solution().divideArray(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func divideArray(_ nums: [Int]) -> Bool {
        let expectedPairsCount = nums.count / 2
        let sortedNums = nums.sorted()
        var outputPairsCount = 0

        var pairIndex = 0
        for index in 0..<expectedPairsCount {
            let firstElement = sortedNums[2*index]
            let secondElement = sortedNums[2*index+1]

            if firstElement == secondElement {
                outputPairsCount += 1
            } else {
                break
            }

            pairIndex += 1
        }

        return outputPairsCount == expectedPairsCount
    }
}

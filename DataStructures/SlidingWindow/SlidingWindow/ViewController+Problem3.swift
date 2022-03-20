//
//  ViewController+Problem3.swift
//  SlidingWindow
//
//  Created by Manish Rathi on 20/03/2022.
//

import Foundation
/*
 1984. Minimum Difference Between Highest and Lowest of K Scores
 https://leetcode.com/problems/minimum-difference-between-highest-and-lowest-of-k-scores/
 You are given a 0-indexed integer array nums, where nums[i] represents the score of the ith student. You are also given an integer k.
 Pick the scores of any k students from the array so that the difference between the highest and the lowest of the k scores is minimized.
 Return the minimum possible difference.

 Example 1:
 Input: nums = [90], k = 1
 Output: 0
 Explanation: There is one way to pick score(s) of one student:
 - [90]. The difference between the highest and lowest score is 90 - 90 = 0.
 The minimum possible difference is 0.

 Example 2:
 Input: nums = [9,4,1,7], k = 2
 Output: 2
 Explanation: There are six ways to pick score(s) of two students:
 - [9,4,1,7]. The difference between the highest and lowest score is 9 - 4 = 5.
 - [9,4,1,7]. The difference between the highest and lowest score is 9 - 1 = 8.
 - [9,4,1,7]. The difference between the highest and lowest score is 9 - 7 = 2.
 - [9,4,1,7]. The difference between the highest and lowest score is 4 - 1 = 3.
 - [9,4,1,7]. The difference between the highest and lowest score is 7 - 4 = 3.
 - [9,4,1,7]. The difference between the highest and lowest score is 7 - 1 = 6.
 The minimum possible difference is 2.
 */

extension ViewController {
    func solve3() {
        print("Setting up Problem3 input!")

        var input = [9,4,1,7]
        print("Input1: \(input)")
        var output = Solution().minimumDifference(input, 2)
        print("Output1: \(output)")

        input = [90]
        print("Input2: \(input)")
        output = Solution().minimumDifference(input, 1)
        print("Output2: \(output)")
    }
}

fileprivate class Solution {
    private var minimumDifference = Int.max

    func minimumDifference(_ nums: [Int], _ k: Int) -> Int {
        if k < 1 { return 0 }

        let slidingWindow = SlidingWindow(nums.sorted())
        let inputNumsCount = nums.count
        let windowSize = k

        while slidingWindow.endIndex < inputNumsCount {
            if slidingWindow.value.count == windowSize {
                let minValue = Array(slidingWindow.startIndexValue).first!
                let maxValue = Array(slidingWindow.endIndexValue).first!

                let currentWindowDifference = maxValue - minValue
                minimumDifference = min(minimumDifference, currentWindowDifference)

                slidingWindow.startIndex += 1
            }

            slidingWindow.endIndex += 1
        }

        return minimumDifference
    }
}

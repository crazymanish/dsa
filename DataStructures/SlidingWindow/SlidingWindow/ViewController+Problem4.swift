//
//  ViewController+Problem4.swift
//  SlidingWindow
//
//  Created by Manish Rathi on 20/03/2022.
//

import Foundation
/*
 643. Maximum Average Subarray I
 https://leetcode.com/problems/maximum-average-subarray-i/
 You are given an integer array nums consisting of n elements, and an integer k.
 Find a contiguous subarray whose length is equal to k that has the maximum average value and return this value. Any answer with a calculation error less than 10-5 will be accepted.

 Example 1:
 Input: nums = [1,12,-5,-6,50,3], k = 4
 Output: 12.75000
 Explanation: Maximum average is (12 - 5 - 6 + 50) / 4 = 51 / 4 = 12.75

 Example 2:
 Input: nums = [5], k = 1
 Output: 5.00000
 */

extension ViewController {
    func solve4() {
        print("Setting up Problem4 input!")

        var input = [1,12,-5,-6,50,3]
        print("Input1: \(input)")
        var output = Solution().findMaxAverage(input, 4)
        print("Output1: \(output)")

        input = [5]
        print("Input2: \(input)")
        output = Solution().findMaxAverage(input, 1)
        print("Output2: \(output)")
    }
}

fileprivate class Solution {
    func findMaxAverage(_ nums: [Int], _ k: Int) -> Double {
        if k < 1 { return 0 }

        let slidingWindow = SlidingWindow(nums)
        let inputNumsCount = nums.count
        let windowSize = k
        var currentSlidingWindowSum: Double = 0
        var maxAverage: Double = Double(Int.min)

        while slidingWindow.endIndex < inputNumsCount {
            let lastValue = Array(slidingWindow.endIndexValue).first!
            currentSlidingWindowSum += Double(lastValue)

            if slidingWindow.value.count == windowSize {
                let currentWindowAverage = currentSlidingWindowSum / Double(windowSize)
                maxAverage = max(maxAverage, currentWindowAverage)

                // Before sliding the window, adjust the sliding-sum
                let startValue = Array(slidingWindow.startIndexValue).first!
                currentSlidingWindowSum -= Double(startValue)
                slidingWindow.startIndex += 1
            }

            slidingWindow.endIndex += 1
        }

        return maxAverage
    }
}

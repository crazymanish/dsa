//
//  ViewController+Problem9.swift
//  SlidingWindow
//
//  Created by Manish Rathi on 20/03/2022.
//

import Foundation
/*
 1493. Longest Subarray of 1's After Deleting One Element
 https://leetcode.com/problems/longest-subarray-of-1s-after-deleting-one-element/
 Given a binary array nums, you should delete one element from it.
 Return the size of the longest non-empty subarray containing only 1's in the resulting array. Return 0 if there is no such subarray.

 Example 1:
 Input: nums = [1,1,0,1]
 Output: 3
 Explanation: After deleting the number in position 2, [1,1,1] contains 3 numbers with value of 1's.

 Example 2:
 Input: nums = [0,1,1,1,0,1,1,0,1]
 Output: 5
 Explanation: After deleting the number in position 4, [0,1,1,1,1,1,0,1] longest subarray with value of 1's is [1,1,1,1,1].

 Example 3:
 Input: nums = [1,1,1]
 Output: 2
 Explanation: You must delete one element.
 */

extension ViewController {
    func solve9() {
        print("Setting up Problem9 input!")

        var input = [1,1,0,1]
        print("Input1: \(input)")
        var output = Solution().longestSubarray(input)
        print("Output1: \(output)")

        input = [0,1,1,1,0,1,1,0,1]
        print("Input2: \(input)")
        output = Solution().longestSubarray(input)
        print("Output2: \(output)")

        input = [1,1,1]
        print("Input3: \(input)")
        output = Solution().longestSubarray(input)
        print("Output3: \(output)")
    }
}

fileprivate class Solution {
    private var slidingWindow: SlidingWindow<[Int]>!
    private var canIgnoreZero = true
    private var currentWindowConsecutiveOnes = 0
    private var maximumConsecutiveOnes = Int.min

    private var slidingWindowFirstValue: Int { Array(slidingWindow.startIndexValue).first! }
    private var slidingWindowLastValue: Int { Array(slidingWindow.endIndexValue).first! }

    func longestSubarray(_ nums: [Int]) -> Int {
        slidingWindow = SlidingWindow(nums)
        let inputNumsCount = nums.count
        var zeroAdjustment = 1

        while slidingWindow.endIndex < inputNumsCount {
            if slidingWindowLastValue == 1 {
                handleWhenValueIsOne()
            } else {
                zeroAdjustment = 0
                handleWhenValueIsZero()
            }
        }

        maximumConsecutiveOnes = (max(maximumConsecutiveOnes, currentWindowConsecutiveOnes)) - zeroAdjustment

        return maximumConsecutiveOnes
    }

    // if sliding value is coming as 1, don't do anything just increment the ConsecutiveOnes
    private func handleWhenValueIsOne() {
        currentWindowConsecutiveOnes += 1
        slidingWindow.endIndex += 1 // Slide window by one from end.
    }

    private func handleWhenValueIsZero() {
        // lets see if have chance to make 0 into 1 first using K(flipPossibleCount) value
        if canIgnoreZero {
            canIgnoreZero = false
            slidingWindow.endIndex += 1 // Slide window by one from end.
        } else {
            // We found maximum ConsecutiveOnes in this sliding-window
            maximumConsecutiveOnes = max(maximumConsecutiveOnes, currentWindowConsecutiveOnes)

            while slidingWindowFirstValue != 0 {
                // Adjust currentWindowConsecutiveOnes, before sliding next window
                currentWindowConsecutiveOnes -= 1

                slidingWindow.startIndex += 1 // Slide window by one from start.
            }

            canIgnoreZero = true
            slidingWindow.startIndex += 1 // Slide window by one from start.
        }
    }
}

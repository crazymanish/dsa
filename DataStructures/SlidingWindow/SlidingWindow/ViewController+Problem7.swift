//
//  ViewController+Problem7.swift
//  SlidingWindow
//
//  Created by Manish Rathi on 20/03/2022.
//

import Foundation
/*
 1004. Max Consecutive Ones III
 https://leetcode.com/problems/max-consecutive-ones-iii/
 Given a binary array nums and an integer k, return the maximum number of consecutive 1's in the array if you can flip at most k 0's.

 Example 1:
 Input: nums = [1,1,1,0,0,0,1,1,1,1,0], k = 2
 Output: 6
 Explanation: [1,1,1,0,0,1,1,1,1,1,1]
 Bolded numbers were flipped from 0 to 1. The longest subarray is underlined.

 Example 2:
 Input: nums = [0,0,1,1,0,0,1,1,1,0,1,1,0,0,0,1,1,1,1], k = 3
 Output: 10
 Explanation: [0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1]
 Bolded numbers were flipped from 0 to 1. The longest subarray is underlined.
 */

extension ViewController {
    func solve7() {
        print("Setting up Problem7 input!")

        var input = [1,1,1,0,0,0,1,1,1,1,0]
        print("Input1: \(input)")
        var output = Solution().longestOnes(input, 2)
        print("Output1: \(output)")

        input = [0,0,1,1,0,0,1,1,1,0,1,1,0,0,0,1,1,1,1]
        print("Input2: \(input)")
        output = Solution().longestOnes(input, 3)
        print("Output2: \(output)")

        input = [0,0,0,1]
        print("Input3: \(input)")
        output = Solution().longestOnes(input, 4)
        print("Output3: \(output)")
    }
}

fileprivate class Solution {
    private var slidingWindow: SlidingWindow<[Int]>!
    private var flipPossibleCount: Int!
    private var currentWindowConsecutiveOnes = 0
    private var maximumConsecutiveOnes = Int.min

    private var slidingWindowFirstValue: Int { Array(slidingWindow.startIndexValue).first! }
    private var slidingWindowLastValue: Int { Array(slidingWindow.endIndexValue).first! }

    func longestOnes(_ nums: [Int], _ k: Int) -> Int {
        slidingWindow = SlidingWindow(nums)
        flipPossibleCount = k
        let inputNumsCount = nums.count

        while slidingWindow.endIndex < inputNumsCount {
            if slidingWindowLastValue == 1 {
                handleWhenValueIsOne()
            } else {
                handleWhenValueIsZero()
            }
        }

        maximumConsecutiveOnes = max(maximumConsecutiveOnes, currentWindowConsecutiveOnes)

        return maximumConsecutiveOnes
    }

    // if sliding value is coming as 1, don't do anything just increment the ConsecutiveOnes
    private func handleWhenValueIsOne() {
        currentWindowConsecutiveOnes += 1
        slidingWindow.endIndex += 1 // Slide window by one from end.
    }

    private func handleWhenValueIsZero() {
        // lets see if have chance to make 0 into 1 first using K(flipPossibleCount) value
        if flipPossibleCount > 0 {
            flipPossibleCount -= 1
            currentWindowConsecutiveOnes += 1
            slidingWindow.endIndex += 1 // Slide window by one from end.
        } else if flipPossibleCount == 0 {
            // We found maximum ConsecutiveOnes in this sliding-window
            maximumConsecutiveOnes = max(maximumConsecutiveOnes, currentWindowConsecutiveOnes)
            print("\(maximumConsecutiveOnes) :: \(currentWindowConsecutiveOnes) -> \(slidingWindow.value)")

            // Adjust currentWindowConsecutiveOnes, before sliding next window
            currentWindowConsecutiveOnes -= 1

            if slidingWindowFirstValue == 0 {
                flipPossibleCount += 1
            }

            slidingWindow.startIndex += 1 // Slide window by one from start.
        }
    }
}

//
//  ViewController+Problem10.swift
//  SlidingWindow
//
//  Created by Manish Rathi on 20/03/2022.
//

import Foundation
/*
 1248. Count Number of Nice Subarrays
 https://leetcode.com/problems/count-number-of-nice-subarrays/
 Given an array of integers nums and an integer k. A continuous subarray is called nice if there are k odd numbers on it.

 Return the number of nice sub-arrays.

 Example 1:
 Input: nums = [1,1,2,1,1], k = 3
 Output: 2
 Explanation: The only sub-arrays with 3 odd numbers are [1,1,2,1] and [1,2,1,1].

 Example 2:
 Input: nums = [2,4,6], k = 1
 Output: 0
 Explanation: There is no odd numbers in the array.

 Example 3:
 Input: nums = [2,2,2,1,2,2,1,2,2,2], k = 2
 Output: 16
 */

extension ViewController {
    func solve10() {
        print("Setting up Problem10 input!")

        var input = [1,1,2,1,1]
        print("Input1: \(input)")
        var output = Solution().numberOfSubarrays(input, 3)
        print("Output1: \(output)")

        input = [2,4,6]
        print("Input2: \(input)")
        output = Solution().numberOfSubarrays(input, 1)
        print("Output2: \(output)")

        input = [2,2,2,1,2,2,1,2,2,2]
        print("Input3: \(input)")
        output = Solution().numberOfSubarrays(input, 2)
        print("Output3: \(output)")
    }
}

fileprivate class Solution {
    private var slidingWindow: SlidingWindow<[Int]>!
    private var currentSlidingWindowSubarrays = 0
    private var numberOfSubarrays = 0
    private var targetOddNumbers = 0

    private var slidingWindowFirstValue: Int { Array(slidingWindow.startIndexValue).first! }
    private var slidingWindowLastValue: Int { Array(slidingWindow.endIndexValue).first! }

    func numberOfSubarrays(_ nums: [Int], _ k: Int) -> Int {
        slidingWindow = SlidingWindow(nums)
        targetOddNumbers = k

        while slidingWindow.endIndex < nums.count {
            if slidingWindowLastValue % 2 != 0 { handleWhenValueIsOdd() }

            handleWhenTargetOddNumbersConditionMet()

            numberOfSubarrays += currentSlidingWindowSubarrays

            // Slide window by one from end.
            slidingWindow.endIndex += 1
        }

        return numberOfSubarrays
    }

    private func handleWhenValueIsOdd() {
        targetOddNumbers -= 1
        currentSlidingWindowSubarrays = 0
    }

    private func handleWhenTargetOddNumbersConditionMet() {
        while targetOddNumbers == 0 {
            if slidingWindowFirstValue % 2 != 0 { targetOddNumbers += 1 }

            currentSlidingWindowSubarrays += 1
            slidingWindow.startIndex += 1 // Slide window by one from start.
        }
    }
}

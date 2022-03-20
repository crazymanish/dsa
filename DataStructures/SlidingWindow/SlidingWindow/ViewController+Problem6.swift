//
//  ViewController+Problem6.swift
//  SlidingWindow
//
//  Created by Manish Rathi on 20/03/2022.
//

import Foundation
/*
 1343. Number of Sub-arrays of Size K and Average Greater than or Equal to Threshold
 https://leetcode.com/problems/number-of-sub-arrays-of-size-k-and-average-greater-than-or-equal-to-threshold/
 Given an array of integers arr and two integers k and threshold, return the number of sub-arrays of size k and average greater than or equal to threshold.

 Example 1:
 Input: arr = [2,2,2,2,5,5,5,8], k = 3, threshold = 4
 Output: 3
 Explanation: Sub-arrays [2,5,5],[5,5,5] and [5,5,8] have averages 4, 5 and 6 respectively. All other sub-arrays of size 3 have averages less than 4 (the threshold).

 Example 2:
 Input: arr = [11,13,17,23,29,31,7,5,2,3], k = 3, threshold = 5
 Output: 6
 Explanation: The first 6 sub-arrays of size 3 have averages greater than 5. Note that averages are not integers.
 */

extension ViewController {
    func solve6() {
        print("Setting up Problem6 input!")

        var input = [2,2,2,2,5,5,5,8]
        print("Input1: \(input)")
        var output = Solution().numOfSubarrays(input, 3, 4)
        print("Output1: \(output)")

        input = [11,13,17,23,29,31,7,5,2,3]
        print("Input2: \(input)")
        output = Solution().numOfSubarrays(input, 3, 5)
        print("Output2: \(output)")
    }
}

fileprivate class Solution {
    private var slidingWindowSize: Int!
    private var slidingWindow: SlidingWindow<[Int]>!
    private var currentSlidingWindowSum: Double = 0
    private var numOfSubarrays: Int = 0

    func numOfSubarrays(_ arr: [Int], _ k: Int, _ threshold: Int) -> Int {
        slidingWindow = SlidingWindow(arr)
        slidingWindowSize = k
        let inputNumsCount = arr.count

        while slidingWindow.endIndex < inputNumsCount {
            handleScenarioBeforeReachingTheWindowSize()

            handleScenarioOnReachingTheWindowSize(threshold)

            // Slide window by one from end.
            slidingWindow.endIndex += 1
        }

        return numOfSubarrays
    }

    private func handleScenarioBeforeReachingTheWindowSize() {
        // Just keep adding values into sum
        if slidingWindow.value.count <= slidingWindowSize {
            let lastValue = Array(slidingWindow.endIndexValue).first!

            currentSlidingWindowSum += Double(lastValue)
        }
    }

    private func handleScenarioOnReachingTheWindowSize(_ threshold: Int) {
        if slidingWindow.value.count == slidingWindowSize {
            let currentWindowAvg = currentSlidingWindowSum / Double(slidingWindowSize)
            if currentWindowAvg >= Double(threshold) {
                numOfSubarrays += 1 // YaY: Found valid sub-array
            }

            // Remove start window element from current-sum, before sliding next window
            let startValue = Array(slidingWindow.startIndexValue).first!
            currentSlidingWindowSum -= Double(startValue)

            // Slide window by one from start.
            slidingWindow.startIndex += 1
        }
    }
}

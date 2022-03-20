//
//  ViewController+Problem5.swift
//  SlidingWindow
//
//  Created by Manish Rathi on 20/03/2022.
//

import Foundation
/*
 219. Contains Duplicate II
 https://leetcode.com/problems/contains-duplicate-ii/
 Given an integer array nums and an integer k, return true if there are two distinct indices i and j in the array such that nums[i] == nums[j] and abs(i - j) <= k.

 Example 1:
 Input: nums = [1,2,3,1], k = 3
 Output: true

 Example 2:
 Input: nums = [1,0,1,1], k = 1
 Output: true

 Example 3:
 Input: nums = [1,2,3,1,2,3], k = 2
 Output: false
 */

extension ViewController {
    func solve5() {
        print("Setting up Problem5 input!")

        var input = [1,2,3,1]
        print("Input1: \(input)")
        var output = Solution().containsNearbyDuplicate(input, 3)
        print("Output1: \(output)")

        input = [1,0,1,1]
        print("Input2: \(input)")
        output = Solution().containsNearbyDuplicate(input, 1)
        print("Output2: \(output)")

        input = [1,2,3,1,2,3]
        print("Input3: \(input)")
        output = Solution().containsNearbyDuplicate(input, 2)
        print("Output3: \(output)")
    }
}

fileprivate class Solution {
    typealias ValueIndex = [Int : Int]
    private var hashMap: ValueIndex = [:]
    private let slidingWindowSize = 2
    private var slidingWindow: SlidingWindow<[Int]>!

    func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
        slidingWindow = SlidingWindow(nums)
        let inputNumsCount = nums.count
        var isNearbyDuplicateFound = false

        while slidingWindow.endIndex < inputNumsCount {
            handleScenarioBeforeReachingTheWindowSize()
            isNearbyDuplicateFound = handleScenarioOnReachingTheWindowSize(k)

            if isNearbyDuplicateFound { break }

            // Slide window by one from end.
            slidingWindow.endIndex += 1
        }

        return isNearbyDuplicateFound
    }

    private func handleScenarioBeforeReachingTheWindowSize() {
        // Just keep adding values into hash with index
        if slidingWindow.value.count < slidingWindowSize {
            let lastValue = Array(slidingWindow.endIndexValue).first!

            hashMap[lastValue] = slidingWindow.endIndex
        }
    }

    private func handleScenarioOnReachingTheWindowSize(_ k: Int) -> Bool {
        if slidingWindow.value.count == slidingWindowSize {
            let lastValue = Array(slidingWindow.endIndexValue).first!

            if let cacheIndex = hashMap[lastValue], abs(cacheIndex - slidingWindow.endIndex) <= k {
                return true // Found the NearBy duplicate
            }
            hashMap[lastValue] = slidingWindow.endIndex

            // Slide window by one from start.
            slidingWindow.startIndex += 1
        }

        return false
    }
}

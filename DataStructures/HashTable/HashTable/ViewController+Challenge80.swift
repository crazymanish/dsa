//
//  ViewController+Challenge80.swift
//  HashTable
//
//  Created by Manish Rathi on 01/04/2022.
//

import Foundation
/*
 347. Top K Frequent Elements
 https://leetcode.com/problems/top-k-frequent-elements/
 Given an integer array nums and an integer k, return the k most frequent elements. You may return the answer in any order.

 Example 1:
 Input: nums = [1,1,1,2,2,3], k = 2
 Output: [1,2]

 Example 2:
 Input: nums = [1], k = 1
 Output: [1]
 */

extension ViewController {
    func solve80() {
        print("Setting up Challenge80 input!")

        let input = [1,1,1,2,2,3]
        print("Input: \(input)")
        let output = Solution().topKFrequent(input, 2)
        print("Output: \(output)")
    }
}

private class Solution {
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        var hashMap: [Int: Int] = [:]
        for num in nums { hashMap[num] = (hashMap[num] ?? 0) + 1 }

        var output: [Int] = []
        var mutableK = k

        while (mutableK > 0)  {
            var maximumFrequencyKey: Int = Int.min
            var maximumFrequency = Int.min

            for (key, value) in hashMap {
                if value > maximumFrequency {
                    maximumFrequencyKey = key
                    maximumFrequency = value
                }
            }

            output.append(maximumFrequencyKey)

            hashMap[maximumFrequencyKey] = 0
            mutableK -= 1
        }

        return output
    }
}

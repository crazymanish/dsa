//
//  ViewController+Challenge44.swift
//  HashTable
//
//  Created by Manish Rathi on 28/03/2022.
//

import Foundation
/*
 350. Intersection of Two Arrays II
 https://leetcode.com/problems/intersection-of-two-arrays-ii/
 Given two integer arrays nums1 and nums2, return an array of their intersection. Each element in the result must appear as many times as it shows in both arrays and you may return the result in any order.

 Example 1:
 Input: nums1 = [1,2,2,1], nums2 = [2,2]
 Output: [2,2]

 Example 2:
 Input: nums1 = [4,9,5], nums2 = [9,4,9,8,4]
 Output: [4,9]
 Explanation: [9,4] is also accepted.
 */

extension ViewController {
    func solve44() {
        print("Setting up Challenge44 input!")

        let input = [4,9,5]
        print("Input: \(input)")
        let output = Solution().intersect(input, [9,4,9,8,4])
        print("Output: \(output)")
    }
}

private class Solution {
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        let hashMap1 = hashMap(nums1)
        let hashMap2 = hashMap(nums2)

        if nums1.count < nums2.count {
            return intersect(hashMap1, hashMap2)
        } else {
            return intersect(hashMap2, hashMap1)
        }
    }

    private func intersect(
        _ hashMap1: [Int : Int],
        _ hashMap2: [Int : Int]) -> [Int] {
        var outputArray: [Int] = []

        for (key, value) in hashMap1 {
            let value2 = hashMap2[key] ?? 0
            let minValue = min(value, value2)

            for _ in 0..<minValue {
               outputArray.append(key)
            }
        }

        return outputArray
    }

    private func hashMap(_ nums: [Int]) -> [Int : Int] {
        var hashMap: [Int : Int] = [:]

        for num in nums {
            let hashMapValue = hashMap[num] ?? 0
            hashMap[num] = hashMapValue + 1
        }

        return hashMap
    }
}

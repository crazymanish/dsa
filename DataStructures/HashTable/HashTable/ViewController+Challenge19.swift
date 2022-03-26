//
//  ViewController+Challenge19.swift
//  HashTable
//
//  Created by Manish Rathi on 26/03/2022.
//

import Foundation
/*
 349. Intersection of Two Arrays
 https://leetcode.com/problems/intersection-of-two-arrays/
 Given two integer arrays nums1 and nums2, return an array of their intersection. Each element in the result must be unique and you may return the result in any order.

 Example 1:
 Input: nums1 = [1,2,2,1], nums2 = [2,2]
 Output: [2]

 Example 2:
 Input: nums1 = [4,9,5], nums2 = [9,4,9,8,4]
 Output: [9,4]
 Explanation: [4,9] is also accepted.
 */

extension ViewController {
    func solve19() {
        print("Setting up Challenge19 input!")

        let input = [4,9,5]
        print("Input: \(input)")
        let output = Solution().intersection(input, [9,4,9,8,4])
        print("Output: \(output)")
    }
}

private class Solution {
    func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var hashMap: [Int : Bool] = [:]
        for num in nums1 { hashMap[num] = true }

        var outputHashMap: [Int: Bool] = [:]
        for num in nums2 { if hashMap[num] != nil { outputHashMap[num] = true } }

        return Array(outputHashMap.keys)
    }
}

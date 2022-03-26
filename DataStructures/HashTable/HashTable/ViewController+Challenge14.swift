//
//  ViewController+Challenge14.swift
//  HashTable
//
//  Created by Manish Rathi on 26/03/2022.
//

import Foundation
/*
 2032. Two Out of Three
 https://leetcode.com/problems/two-out-of-three/
 Given three integer arrays nums1, nums2, and nums3, return a distinct array containing all the values that are present in at least two out of the three arrays. You may return the values in any order.

 Example 1:
 Input: nums1 = [1,1,3,2], nums2 = [2,3], nums3 = [3]
 Output: [3,2]
 Explanation: The values that are present in at least two arrays are:
 - 3, in all three arrays.
 - 2, in nums1 and nums2.

 Example 2:
 Input: nums1 = [3,1], nums2 = [2,3], nums3 = [1,2]
 Output: [2,3,1]
 Explanation: The values that are present in at least two arrays are:
 - 2, in nums2 and nums3.
 - 3, in nums1 and nums2.
 - 1, in nums1 and nums3.

 Example 3:
 Input: nums1 = [1,2,2], nums2 = [4,3,3], nums3 = [5]
 Output: []
 Explanation: No value is present in at least two arrays.
 */

extension ViewController {
    func solve14() {
        print("Setting up Challenge14 input!")

        let input = [1,1,3,2]
        print("Input: \(input)")
        let output = Solution().twoOutOfThree(input, [2,3], [3])
        print("Output: \(output)")
    }
}

private class Solution {
    func twoOutOfThree(_ nums1: [Int], _ nums2: [Int], _ nums3: [Int]) -> [Int] {
        var hashMap: [Int : [Int : Bool]] = [:]

        for num in nums1 {
            if hashMap[num] == nil {
                hashMap[num] = [1 : true]
            }
        }

        for num in nums2 {
            if var hashMapValue = hashMap[num] {
                if hashMapValue[2] == nil {
                    hashMapValue[2] = true
                    hashMap[num] = hashMapValue
                }
            } else {
                hashMap[num] = [2 : true]
            }
        }

        for num in nums3 {
            if var hashMapValue = hashMap[num] {
                if hashMapValue[3] == nil {
                    hashMapValue[3] = true
                    hashMap[num] = hashMapValue
                }
            } else {
                hashMap[num] = [3 : true]
            }
        }


        var output: [Int] = []
        for (key, value) in hashMap {
            if value.keys.count > 1 { output.append(key) }
        }

        return output
    }
}

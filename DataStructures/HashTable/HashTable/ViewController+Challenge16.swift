//
//  ViewController+Challenge16.swift
//  HashTable
//
//  Created by Manish Rathi on 26/03/2022.
//

import Foundation
/*
 1460. Make Two Arrays Equal by Reversing Sub-arrays
 https://leetcode.com/problems/make-two-arrays-equal-by-reversing-sub-arrays/
 You are given two integer arrays of equal length target and arr. In one step, you can select any non-empty sub-array of arr and reverse it. You are allowed to make any number of steps.
 Return true if you can make arr equal to target or false otherwise.

 Example 1:
 Input: target = [1,2,3,4], arr = [2,4,1,3]
 Output: true
 Explanation: You can follow the next steps to convert arr to target:
 1- Reverse sub-array [2,4,1], arr becomes [1,4,2,3]
 2- Reverse sub-array [4,2], arr becomes [1,2,4,3]
 3- Reverse sub-array [4,3], arr becomes [1,2,3,4]
 There are multiple ways to convert arr to target, this is not the only way to do so.

 Example 2:
 Input: target = [7], arr = [7]
 Output: true
 Explanation: arr is equal to target without any reverses.

 Example 3:
 Input: target = [3,7,9], arr = [3,7,11]
 Output: false
 Explanation: arr does not have value 9 and it can never be converted to target.
 */

extension ViewController {
    func solve16() {
        print("Setting up Challenge16 input!")

        let input = [1,2,3,4]
        print("Input: \(input)")
        let output = Solution().canBeEqual(input, [2,4,1,3])
        print("Output: \(output)")
    }
}

private class Solution {
    func canBeEqual(_ target: [Int], _ arr: [Int]) -> Bool {
        var hashMap: [Int : Int] = [:]

        for number in arr {
            if let hashMapValue = hashMap[number] {
                hashMap[number] = hashMapValue + 1
            } else {
                hashMap[number] = 1
            }
        }

        var canBeEqual = true
        for number in target {
            if let hashMapValue = hashMap[number] {
                hashMap[number] = hashMapValue - 1
            } else {
                canBeEqual = false
                break
            }
        }

        if canBeEqual {
            for (_, value) in hashMap {
                if value != 0 {
                    canBeEqual = false
                    break
                }
            }
        }

        return canBeEqual
    }
}

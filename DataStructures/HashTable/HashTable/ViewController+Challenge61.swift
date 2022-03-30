//
//  ViewController+Challenge61.swift
//  HashTable
//
//  Created by Manish Rathi on 30/03/2022.
//

import Foundation
/*
 1346. Check If N and Its Double Exist
 https://leetcode.com/problems/check-if-n-and-its-double-exist/
 Given an array arr of integers, check if there exists two integers N and M such that N is the double of M ( i.e. N = 2 * M).
 More formally check if there exists two indices i and j such that :
 i != j
 0 <= i, j < arr.length
 arr[i] == 2 * arr[j]

 Example 1:
 Input: arr = [10,2,5,3]
 Output: true
 Explanation: N = 10 is the double of M = 5,that is, 10 = 2 * 5.

 Example 2:
 Input: arr = [7,1,14,11]
 Output: true
 Explanation: N = 14 is the double of M = 7,that is, 14 = 2 * 7.

 Example 3:
 Input: arr = [3,1,7,11]
 Output: false
 Explanation: In this case does not exist N and M, such that N = 2 * M.
 */

extension ViewController {
    func solve61() {
        print("Setting up Challenge61 input!")

        let input = [10,2,5,3]
        print("Input: \(input)")
        let output = Solution().checkIfExist(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func checkIfExist(_ array: [Int]) -> Bool {
        var hashMap: [Int : Bool] = [:]

        for element in array {
            if hashMap[(element * 2)] != nil ||
            (element % 2 == 0 && hashMap[(element / 2)] != nil) {
                return true
            } else {
                hashMap[element] = true
            }
        }

        return false
    }
}

//
//  ViewController+Challenge50.swift
//  HashTable
//
//  Created by Manish Rathi on 29/03/2022.
//

import Foundation
/*
 1893. Check if All the Integers in a Range Are Covered
 https://leetcode.com/problems/check-if-all-the-integers-in-a-range-are-covered/
 You are given a 2D integer array ranges and two integers left and right. Each ranges[i] = [starti, endi] represents an inclusive interval between starti and endi.
 Return true if each integer in the inclusive range [left, right] is covered by at least one interval in ranges. Return false otherwise.
 An integer x is covered by an interval ranges[i] = [starti, endi] if starti <= x <= endi.

 Example 1:
 Input: ranges = [[1,2],[3,4],[5,6]], left = 2, right = 5
 Output: true
 Explanation: Every integer between 2 and 5 is covered:
 - 2 is covered by the first range.
 - 3 and 4 are covered by the second range.
 - 5 is covered by the third range.

 Example 2:
 Input: ranges = [[1,10],[10,20]], left = 21, right = 21
 Output: false
 Explanation: 21 is not covered by any range.
 */

extension ViewController {
    func solve50() {
        print("Setting up Challenge50 input!")

        let input = [[1,2],[3,4],[5,6]]
        print("Input: \(input)")
        let output = Solution().isCovered(input, 2, 5)
        print("Output: \(output)")
    }
}

private class Solution {
    func isCovered(_ ranges: [[Int]], _ left: Int, _ right: Int) -> Bool {
        var hashMap: [Int : Bool] = [:]

        for rangeValue in left...right {
            hashMap[rangeValue] = false
        }

        for range in ranges {
            for rangeValue in range[0]...range[1] {
                hashMap[rangeValue] = true
            }
        }

        var isCovered = true
        for (_, value) in hashMap {
            if value == false {
                isCovered = false
                break
            }
        }

        return isCovered
    }
}

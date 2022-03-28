//
//  ViewController+Challenge37.swift
//  HashTable
//
//  Created by Manish Rathi on 28/03/2022.
//

import Foundation
/*
 448. Find All Numbers Disappeared in an Array
 https://leetcode.com/problems/find-all-numbers-disappeared-in-an-array/
 Given an array nums of n integers where nums[i] is in the range [1, n], return an array of all the integers in the range [1, n] that do not appear in nums.

 Example 1:
 Input: nums = [4,3,2,7,8,2,3,1]
 Output: [5,6]

 Example 2:
 Input: nums = [1,1]
 Output: [2]
 */

extension ViewController {
    func solve37() {
        print("Setting up Challenge37 input!")

        let input = [4,3,2,7,8,2,3,1]
        print("Input: \(input)")
        let output = Solution().findDisappearedNumbers(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func findDisappearedNumbers(_ numbers: [Int]) -> [Int] {
        var hashMap: [Int : Bool] = [:]
        for number in numbers { hashMap[number] = true }

        var disappearedNumbers: [Int] = []

        for number in 1...numbers.count {
            if hashMap[number] == nil { disappearedNumbers.append(number) }
        }

        return disappearedNumbers
    }
}

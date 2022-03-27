//
//  ViewController+Challenge23.swift
//  HashTable
//
//  Created by Manish Rathi on 27/03/2022.
//

import Foundation
/*
 1399. Count Largest Group
 https://leetcode.com/problems/count-largest-group/
 You are given an integer n.
 Each number from 1 to n is grouped according to the sum of its digits.
 Return the number of groups that have the largest size.

 Example 1:
 Input: n = 13
 Output: 4
 Explanation: There are 9 groups in total, they are grouped according sum of its digits of numbers from 1 to 13:
 [1,10], [2,11], [3,12], [4,13], [5], [6], [7], [8], [9].
 There are 4 groups with largest size.

 Example 2:
 Input: n = 2
 Output: 2
 Explanation: There are 2 groups [1], [2] of size 1.
 */

extension ViewController {
    func solve23() {
        print("Setting up Challenge23 input!")

        let input = 13
        print("Input: \(input)")
        let output = Solution().countLargestGroup(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func countLargestGroup(_ n: Int) -> Int {
        var hashMap: [Int : Int] = [:]

        var mutatedN = n
        while mutatedN > 0 {
            var number = mutatedN
            var numberSum = 0
            while number > 0 {
                numberSum += number % 10
                number /= 10
            }

            if let hashMapValue = hashMap[numberSum] {
                hashMap[numberSum] = hashMapValue + 1
            } else {
                hashMap[numberSum] = 1
            }

            mutatedN -= 1
        }

        var groupHashMap: [Int : Int] = [:]
        for (_, value) in hashMap {
            if let hashMapValue = groupHashMap[value] {
                groupHashMap[value] = hashMapValue + 1
            } else {
                groupHashMap[value] = 1
            }
        }

        var largestGroup: (key: Int, value: Int) = (key: Int.min, value: Int.min)
        for (key, value) in groupHashMap {
            if key > largestGroup.key {
                largestGroup = (key: key, value: value)
            }
        }

        return largestGroup.value
    }
}

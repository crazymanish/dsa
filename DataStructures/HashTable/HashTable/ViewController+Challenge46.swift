//
//  ViewController+Challenge46.swift
//  HashTable
//
//  Created by Manish Rathi on 28/03/2022.
//

import Foundation
/*
 202. Happy Number
 https://leetcode.com/problems/happy-number/
 Write an algorithm to determine if a number n is happy.
 A happy number is a number defined by the following process:
 Starting with any positive integer, replace the number by the sum of the squares of its digits.
 Repeat the process until the number equals 1 (where it will stay), or it loops endlessly in a cycle which does not include 1.
 Those numbers for which this process ends in 1 are happy.
 Return true if n is a happy number, and false if not.

 Example 1:
 Input: n = 19
 Output: true
 Explanation:
 12 + 92 = 82
 82 + 22 = 68
 62 + 82 = 100
 12 + 02 + 02 = 1

 Example 2:
 Input: n = 2
 Output: false
 */

extension ViewController {
    func solve46() {
        print("Setting up Challenge46 input!")

        let input = 19
        print("Input: \(input)")
        let output = Solution().isHappy(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func isHappy(_ n: Int) -> Bool {
        var hashMap: [Int : Bool] = [:]

        var number = n
        var isHappyNumber = false

        while true {
            var sum = 0
            while number != 0 {
                let digit = number % 10
                sum += digit * digit

                number = number / 10
            }

            if sum == 1{
                isHappyNumber = true // YaY, we found it!
                break
            }

            if hashMap[sum] == nil {
                hashMap[sum] = true
            } else {
                isHappyNumber = false // Found endless loop
                break
            }

            number = sum
        }

        return isHappyNumber
    }
}

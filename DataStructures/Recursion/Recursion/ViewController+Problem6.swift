//
//  ViewController+Problem6.swift
//  Recursion
//
//  Created by Manish Rathi on 22/03/2022.
//

import Foundation
/*
 231. Power of Two
 https://leetcode.com/problems/power-of-two/
 Given an integer n, return true if it is a power of two. Otherwise, return false.
 An integer n is a power of two, if there exists an integer x such that n == 2x.

 Example 1:
 Input: n = 1
 Output: true
 Explanation: 20 = 1

 Example 2:
 Input: n = 16
 Output: true
 Explanation: 24 = 16

 Example 3:
 Input: n = 3
 Output: false
 */

extension ViewController {
    func solve6() {
        print("Setting up Problem6 input!")

        var input = 16
        print("Input: \(input)")
        var output = Solution().isPowerOfTwo(input)
        print("Output: \(output)")

        input = 7
        print("Input: \(input)")
        output = Solution().isPowerOfTwo(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func isPowerOfTwo(_ n: Int) -> Bool {
        if n == 1 { return true } // i.e 2° = 1
        if n <= 0 { return false } // i.e 0 or negative value
        if n % 2 == 1 { return false } // i.e 3/2 scenarios

        return isPowerOfTwo(n/2)
    }
}

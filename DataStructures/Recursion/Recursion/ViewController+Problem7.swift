//
//  ViewController+Problem7.swift
//  Recursion
//
//  Created by Manish Rathi on 22/03/2022.
//

import Foundation
/*
 342. Power of Four
 https://leetcode.com/problems/power-of-four/
 Given an integer n, return true if it is a power of four. Otherwise, return false.
 An integer n is a power of four, if there exists an integer x such that n == 4x.

 Example 1:
 Input: n = 16
 Output: true

 Example 2:
 Input: n = 5
 Output: false

 Example 3:
 Input: n = 1
 Output: true
 */

extension ViewController {
    func solve7() {
        print("Setting up Problem7 input!")

        var input = 16
        print("Input: \(input)")
        var output = Solution().isPowerOfFour(input)
        print("Output: \(output)")

        input = 7
        print("Input: \(input)")
        output = Solution().isPowerOfFour(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func isPowerOfFour(_ n: Int) -> Bool {
        if n == 1 { return true } // i.e 4° = 1
        if n <= 0 { return false } // i.e 0 or negative value
        if n % 4 == 1 { return false } // i.e 5/4 scenarios
        if n % 4 == 2 { return false } // i.e 6/4 scenarios
        if n % 4 == 3 { return false } // i.e 7/4 scenarios

        return isPowerOfFour(n/4)
    }
}

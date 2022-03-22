//
//  ViewController+Problem8.swift
//  Recursion
//
//  Created by Manish Rathi on 22/03/2022.
//

import Foundation
/*
 326. Power of Three
 https://leetcode.com/problems/power-of-three/
 Given an integer n, return true if it is a power of three. Otherwise, return false.
 An integer n is a power of three, if there exists an integer x such that n == 3x.

 Example 1:
 Input: n = 27
 Output: true

 Example 2:
 Input: n = 0
 Output: false

 Example 3:
 Input: n = 9
 Output: true
 */

extension ViewController {
    func solve8() {
        print("Setting up Problem8 input!")

        var input = 27
        print("Input: \(input)")
        var output = Solution().isPowerOfThree(input)
        print("Output: \(output)")

        input = 7
        print("Input: \(input)")
        output = Solution().isPowerOfThree(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func isPowerOfThree(_ n: Int) -> Bool {
        if n == 1 { return true } // i.e 3° = 1
        if n <= 0 { return false } // i.e 0 or negative value
        if n % 3 == 1 { return false } // i.e 4/3 scenarios
        if n % 3 == 2 { return false } // i.e 5/3 scenarios

        return isPowerOfThree(n/3)
    }
}

//
//  ViewController+Problem1.swift
//  Recursion
//
//  Created by Manish Rathi on 21/03/2022.
//

import Foundation
/*
 344. Reverse String
 https://leetcode.com/problems/reverse-string/
 Write a function that reverses a string. The input string is given as an array of characters s.
 You must do this by modifying the input array in-place with O(1) extra memory.

 Example 1:
 Input: s = ["h","e","l","l","o"]
 Output: ["o","l","l","e","h"]

 Example 2:
 Input: s = ["H","a","n","n","a","h"]
 Output: ["h","a","n","n","a","H"]
 */

extension ViewController {
    func solve1() {
        print("Setting up Problem1 input!")

        var input: [Character] = ["h", "e", "l", "l", "o"]
        print("Input: \(input)")
        Solution().reverseString(&input)
        print("Output: \(input)")
    }
}

private class Solution {
    func reverseString(_ s: inout [Character]) {
        reverseString(&s, 0, s.count-1)
    }

    private func reverseString(_ s: inout [Character], _ firstIndex: Int, _ lastIndex: Int) {
        guard s.isEmpty == false else { return }

        if firstIndex >= lastIndex { return }

        // Replace first with last now.
        let temp = s[firstIndex]
        s[firstIndex] = s[lastIndex]
        s[lastIndex] = temp

        let newFirstIndex = firstIndex + 1
        let newLastIndex = lastIndex - 1
        reverseString(&s, newFirstIndex, newLastIndex)
    }
}

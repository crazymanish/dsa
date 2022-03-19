//
//  ViewController+Problem1.swift
//  SlidingWindow
//
//  Created by Manish Rathi on 19/03/2022.
//

import Foundation
/*
 1876. Substrings of Size Three with Distinct Characters
 https://leetcode.com/problems/substrings-of-size-three-with-distinct-characters/
 A string is good if there are no repeated characters.
 Given a string s​​​​​, return the number of good substrings of length three in s​​​​​​.
 Note that if there are multiple occurrences of the same substring, every occurrence should be counted.
 A substring is a contiguous sequence of characters in a string.

 Example 1:
 Input: s = "xyzzaz"
 Output: 1
 Explanation: There are 4 substrings of size 3: "xyz", "yzz", "zza", and "zaz".
 The only good substring of length 3 is "xyz".

 Example 2:
 Input: s = "aababcabc"
 Output: 4
 Explanation: There are 7 substrings of size 3: "aab", "aba", "bab", "abc", "bca", "cab", and "abc".
 The good substrings are "abc", "bca", "cab", and "abc".
 */

extension ViewController {
    func solve1() {
        print("Setting up Problem1 input!")

        let input = "xyzzaz"
        print("Input: \(input)")

        let output = Solution().countGoodSubstrings(input)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    func countGoodSubstrings(_ s: String) -> Int {
        return 0
    }
}

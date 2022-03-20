//
//  ViewController+Problem8.swift
//  SlidingWindow
//
//  Created by Manish Rathi on 20/03/2022.
//

import Foundation
/*
 1358. Number of Substrings Containing All Three Characters
 https://leetcode.com/problems/number-of-substrings-containing-all-three-characters/
 Given a string s consisting only of characters a, b and c.
 Return the number of substrings containing at least one occurrence of all these characters a, b and c.

 Example 1:
 Input: s = "abcabc"
 Output: 10
 Explanation: The substrings containing at least one occurrence of the characters a, b and c are "abc", "abca", "abcab", "abcabc", "bca", "bcab", "bcabc", "cab", "cabc" and "abc" (again).

 Example 2:
 Input: s = "aaacb"
 Output: 3
 Explanation: The substrings containing at least one occurrence of the characters a, b and c are "aaacb", "aacb" and "acb".

 Example 3:
 Input: s = "abc"
 Output: 1
 */

extension ViewController {
    func solve8() {
        print("Setting up Problem8 input!")

        var input = "abcabc"
        print("Input1: \(input)")
        var output = Solution().numberOfSubstrings(input)
        print("Output1: \(output)")

        input = "aaacb"
        print("Input2: \(input)")
        output = Solution().numberOfSubstrings(input)
        print("Output2: \(output)")

        input = "abc"
        print("Input3: \(input)")
        output = Solution().numberOfSubstrings(input)
        print("Output3: \(output)")
    }
}

fileprivate class Solution {
    func numberOfSubstrings(_ s: String) -> Int {
        let slidingWindow = SlidingWindow(s)
        var slidingWindowFirstValue: String { String(slidingWindow.startIndexValue) }
        var slidingWindowLastValue: String { String(slidingWindow.endIndexValue) }

        var hashMap = ["a" : 0, "b" : 0, "c" : 0]
        var isFoundSubString: Bool { hashMap["a"]! > 0 && hashMap["b"]! > 0 && hashMap["c"]! > 0 }

        let inputStringCount = s.count
        var numberOfSubstrings = 0

        while slidingWindow.endIndex < inputStringCount {
            let lastValue = slidingWindowLastValue
            hashMap[lastValue] = hashMap[lastValue]! + 1

            while isFoundSubString {
                numberOfSubstrings += (inputStringCount - slidingWindow.endIndex)

                // Update startIndex cache value in HashMap
                let firstValue = slidingWindowFirstValue
                hashMap[firstValue] = hashMap[firstValue]! - 1

                // Move sliding window by 1
                slidingWindow.startIndex += 1
            }

            slidingWindow.endIndex += 1
        }

        return numberOfSubstrings
    }
}

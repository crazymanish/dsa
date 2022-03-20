//
//  ViewController+Problem2.swift
//  SlidingWindow
//
//  Created by Manish Rathi on 20/03/2022.
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
    func solve2() {
        print("Setting up Problem2 input!")

        var input = "YazaAay"
        print("Input1: \(input)")
        var output = Solution().longestNiceSubstring(input)
        print("Output1: \(output)")

        input = "Bb"
        print("Input2: \(input)")
        output = Solution().longestNiceSubstring(input)
        print("Output2: \(output)")
    }
}

fileprivate class Solution {
    func longestNiceSubstring(_ s: String) -> String {
        let slidingWindow = SlidingWindow(s)
        let inputStringCount = s.count
        var longestNiceSubstring = ""

        while slidingWindow.endIndex < inputStringCount {
            let currentWindowString = String(slidingWindow.value)
            let currentWindowStringCount = currentWindowString.count

            if currentWindowString.isNiceString && currentWindowStringCount > longestNiceSubstring.count  {
                longestNiceSubstring = currentWindowString
            }

            // We reached till the end for searching the longest nice string
            if slidingWindow.endIndex == (inputStringCount - 1) {
                // Move sliding window by 1 from start &
                // reset the endIndex to same as startIndex
                slidingWindow.startIndex += 1
                slidingWindow.endIndex = slidingWindow.startIndex - 1
            }

            slidingWindow.endIndex += 1
        }

        return longestNiceSubstring
    }
}

private extension String {
    var isNiceString: Bool {
        Double(Set(self.lowercased()).count) == (Double(Set(self).count) / 2.0)
    }
}

//
//  ViewController+Problem2.swift
//  SlidingWindow
//
//  Created by Manish Rathi on 20/03/2022.
//

import Foundation
/*
 1763. Longest Nice Substring
 https://leetcode.com/problems/longest-nice-substring/
 A string s is nice if, for every letter of the alphabet that s contains, it appears both in uppercase and lowercase. For example, "abABB" is nice because 'A' and 'a' appear, and 'B' and 'b' appear. However, "abA" is not because 'b' appears, but 'B' does not.
 Given a string s, return the longest substring of s that is nice. If there are multiple, return the substring of the earliest occurrence. If there are none, return an empty string.

 Example 1:
 Input: s = "YazaAay"
 Output: "aAa"
 Explanation: "aAa" is a nice string because 'A/a' is the only letter of the alphabet in s, and both 'A' and 'a' appear.
 "aAa" is the longest nice substring.

 Example 2:
 Input: s = "Bb"
 Output: "Bb"
 Explanation: "Bb" is a nice string because both 'B' and 'b' appear. The whole string is a substring.

 Example 3:
 Input: s = "c"
 Output: ""
 Explanation: There are no nice substrings.
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

//
//  ViewController+Problem11.swift
//  SlidingWindow
//
//  Created by Manish Rathi on 20/03/2022.
//

import Foundation
/*
 1456. Maximum Number of Vowels in a Substring of Given Length
 https://leetcode.com/problems/maximum-number-of-vowels-in-a-substring-of-given-length/
 Given a string s and an integer k, return the maximum number of vowel letters in any substring of s with length k.
 Vowel letters in English are 'a', 'e', 'i', 'o', and 'u'.

 Example 1:

 Input: s = "abciiidef", k = 3
 Output: 3
 Explanation: The substring "iii" contains 3 vowel letters.

 Example 2:
 Input: s = "aeiou", k = 2
 Output: 2
 Explanation: Any substring of length 2 contains 2 vowels.

 Example 3:
 Input: s = "leetcode", k = 3
 Output: 2
 Explanation: "lee", "eet" and "ode" contain 2 vowels.
 */

extension ViewController {
    func solve11() {
        print("Setting up Problem11 input!")

        var input = "abciiidef"
        print("Input1: \(input)")
        var output = Solution().maxVowels(input, 3)
        print("Output1: \(output)")

        input = "aeiou"
        print("Input2: \(input)")
        output = Solution().maxVowels(input, 2)
        print("Output2: \(output)")

        input = "leetcode"
        print("Input3: \(input)")
        output = Solution().maxVowels(input, 2)
        print("Output3: \(output)")
    }
}

fileprivate class Solution {
    private var slidingWindow: SlidingWindow<String>!
    private var slidingWindowSize = 0
    private var currentSlidingWindowVowelsLength = 0
    private var maximumVowelsLength = Int.min

    private var vowelsHashMap = ["a": true, "e": true, "i": true, "o": true, "u": true]

    private var slidingWindowFirstValue: String { String(slidingWindow.startIndexValue) }
    private var slidingWindowLastValue: String { String(slidingWindow.endIndexValue) }

    func maxVowels(_ s: String, _ k: Int) -> Int {
        slidingWindow = SlidingWindow(s)
        slidingWindowSize = k

        while slidingWindow.endIndex < s.count {
            if isVowel(slidingWindowLastValue) {
                handleWhenValueIsVowel()
            }

            if slidingWindow.size == slidingWindowSize {
                handleWhenWindowSizeIsMet()
            }

            // Slide window by one from end.
            slidingWindow.endIndex += 1
        }

        return maximumVowelsLength
    }

    private func isVowel(_ string: String) -> Bool { vowelsHashMap[string] != nil }

    private func handleWhenValueIsVowel() {
        currentSlidingWindowVowelsLength += 1
    }

    private func handleWhenWindowSizeIsMet() {
        maximumVowelsLength = max(maximumVowelsLength, currentSlidingWindowVowelsLength)

        if isVowel(slidingWindowFirstValue) {
            currentSlidingWindowVowelsLength -= 1
        }

        slidingWindow.startIndex += 1 // Slide window by one from start.
    }
}

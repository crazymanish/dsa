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

        var input = "xyzzaz"
        print("Input1: \(input)")
        var output = Solution().countGoodSubstrings(input)
        print("Output1: \(output)")

        input = "aababcabc"
        print("Input2: \(input)")
        output = Solution().countGoodSubstrings(input)
        print("Output2: \(output)")
    }
}

fileprivate class Solution {
    private var hashMap: [String : Int] = [:]
    private var hashMapCounter = 0

    func countGoodSubstrings(_ s: String) -> Int {
        let slidingWindow = SlidingWindow(s)
        let windowSize = 3
        var goodStringsCount = 0

        while slidingWindow.endIndex < s.count {
            // Do cache endIndex value in HashMap
            let endValue = String(slidingWindow.endIndexValue)
            addIntoHashMap(endValue)

            let currentWindowValue = slidingWindow.value

            if currentWindowValue.count == windowSize {
                // Found the Good string!
                if hashMapCounter == windowSize { goodStringsCount += 1 }

                // Update startIndex cache value in HashMap
                let startValue = String(slidingWindow.startIndexValue)
                removeFromHashMap(startValue)

                // Move sliding window by 1
                slidingWindow.startIndex += 1
            }

            slidingWindow.endIndex += 1
        }

        return goodStringsCount
    }

    private func addIntoHashMap(_ value: String) {
        if let cacheValue = hashMap[value] {
            hashMap[value] = cacheValue + 1
        } else {
            hashMap[value] = 1
            hashMapCounter += 1
        }
    }

    private func removeFromHashMap(_ value: String) {
        if let cacheValue = hashMap[value] {
            hashMap[value] = cacheValue - 1
            if hashMap[value]! == 0 {
                hashMap.removeValue(forKey: value)
                hashMapCounter -= 1
            }
        }
    }
}

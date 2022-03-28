//
//  ViewController+Challenge35.swift
//  HashTable
//
//  Created by Manish Rathi on 28/03/2022.
//

import Foundation
/*
 1624. Largest Substring Between Two Equal Characters
 https://leetcode.com/problems/largest-substring-between-two-equal-characters/
 Given a string s, return the length of the longest substring between two equal characters, excluding the two characters. If there is no such substring return -1.
 A substring is a contiguous sequence of characters within a string.

 Example 1:
 Input: s = "aa"
 Output: 0
 Explanation: The optimal substring here is an empty substring between the two 'a's.

 Example 2:
 Input: s = "abca"
 Output: 2
 Explanation: The optimal substring here is "bc".

 Example 3:
 Input: s = "cbzxy"
 Output: -1
 Explanation: There are no characters that appear twice in s.
 */

extension ViewController {
    func solve35() {
        print("Setting up Challenge35 input!")

        let input = "abca"
        print("Input: \(input)")
        let output = Solution().maxLengthBetweenEqualCharacters(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func maxLengthBetweenEqualCharacters(_ string: String) -> Int {
        var hashMap: [Character : Index] = [:]

        var index = 0
        for char in string {
            if let hashMapValue = hashMap[char] {
                hashMapValue.endIndex = index
            } else {
                hashMap[char] = Index(index, -1)
            }

            index += 1
        }

        var maxLengthIndex = Index(-1, -1)

        for (_, value) in hashMap {
            maxLengthIndex = maxLength(maxLengthIndex, value)
        }

        if maxLengthIndex.endIndex == -1 { return -1 }

        return maxLengthIndex.endIndex - maxLengthIndex.startIndex - 1
    }

    private func maxLength(_ index1: Index, _ index2: Index) -> Index {
        let index1Length = index1.endIndex - index1.startIndex
        let index2Length = index2.endIndex - index2.startIndex

        if index1Length > index2Length {
            return index1
        } else {
            return index2
        }
    }
}

private class Index {
    let startIndex: Int
    var endIndex: Int

    init(_ startIndex: Int, _ endIndex: Int) {
        self.startIndex = startIndex
        self.endIndex = endIndex
    }
}

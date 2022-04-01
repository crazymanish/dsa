//
//  ViewController+Challenge68.swift
//  HashTable
//
//  Created by Manish Rathi on 01/04/2022.
//

import Foundation
/*
 763. Partition Labels
 https://leetcode.com/problems/partition-labels/
 You are given a string s. We want to partition the string into as many parts as possible so that each letter appears in at most one part.
 Note that the partition is done so that after concatenating all the parts in order, the resultant string should be s.
 Return a list of integers representing the size of these parts.

 Example 1:
 Input: s = "ababcbacadefegdehijhklij"
 Output: [9,7,8]
 Explanation:
 The partition is "ababcbaca", "defegde", "hijhklij".
 This is a partition so that each letter appears in at most one part.
 A partition like "ababcbacadefegde", "hijhklij" is incorrect, because it splits s into less parts.

 Example 2:
 Input: s = "eccbbbbdec"
 Output: [10]
 */

extension ViewController {
    func solve68() {
        print("Setting up Challenge68 input!")

        let input = "ababcbacadefegdehijhklij"
        print("Input: \(input)")
        let output = Solution().partitionLabels(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func partitionLabels(_ s: String) -> [Int] {
        typealias LastIndex = Int
        var hashMap: [Character : LastIndex] = [:]

        var index = 0
        for char in s {
            hashMap[char] = index

            index += 1
        }

        var output: [Int] = []

        var currentPartitionLength = 0
        var currentPartitionEndIndex = 0
        var currentIndex = 0
        for char in s {
            let currentCharLastIndex = hashMap[char]!
            currentPartitionEndIndex = max(currentPartitionEndIndex, currentCharLastIndex)
            currentPartitionLength += 1

            if currentIndex == currentPartitionEndIndex {
                output.append(currentPartitionLength)
                currentPartitionLength = 0
            }

            currentIndex += 1
        }

        return output
    }
}

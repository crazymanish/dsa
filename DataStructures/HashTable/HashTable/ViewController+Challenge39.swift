//
//  ViewController+Challenge39.swift
//  HashTable
//
//  Created by Manish Rathi on 28/03/2022.
//

import Foundation
/*
 1331. Rank Transform of an Array
 https://leetcode.com/problems/rank-transform-of-an-array/
 Given an array of integers arr, replace each element with its rank.
 The rank represents how large the element is. The rank has the following rules:
 Rank is an integer starting from 1.
 The larger the element, the larger the rank. If two elements are equal, their rank must be the same.
 Rank should be as small as possible.

 Example 1:
 Input: arr = [40,10,20,30]
 Output: [4,1,2,3]
 Explanation: 40 is the largest element. 10 is the smallest. 20 is the second smallest. 30 is the third smallest.

 Example 2:
 Input: arr = [100,100,100]
 Output: [1,1,1]
 Explanation: Same elements share the same rank.

 Example 3:
 Input: arr = [37,12,28,9,100,56,80,5,12]
 Output: [5,3,4,2,8,6,7,1,3]
 */

extension ViewController {
    func solve39() {
        print("Setting up Challenge39 input!")

        let input = [40,10,20,30]
        print("Input: \(input)")
        let output = Solution().arrayRankTransform(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func arrayRankTransform(_ array: [Int]) -> [Int] {
        let sortedArray = array.sorted()

        var hashMap: [Int : Int] = [:]

        var currentRank = 1
        for element in sortedArray {
            if hashMap[element] == nil {
                hashMap[element] = currentRank
                currentRank += 1
            }
        }

        var outputArray: [Int] = []
        for element in array {
            outputArray.append(hashMap[element]!)
        }

        return outputArray
    }
}

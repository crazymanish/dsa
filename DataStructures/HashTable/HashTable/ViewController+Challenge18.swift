//
//  ViewController+Challenge18.swift
//  HashTable
//
//  Created by Manish Rathi on 26/03/2022.
//

import Foundation
/*
 2085. Count Common Words With One Occurrence
 https://leetcode.com/problems/count-common-words-with-one-occurrence/
 Given two string arrays words1 and words2, return the number of strings that appear exactly once in each of the two arrays.

 Example 1:
 Input: words1 = ["leetcode","is","amazing","as","is"], words2 = ["amazing","leetcode","is"]
 Output: 2
 Explanation:
 - "leetcode" appears exactly once in each of the two arrays. We count this string.
 - "amazing" appears exactly once in each of the two arrays. We count this string.
 - "is" appears in each of the two arrays, but there are 2 occurrences of it in words1. We do not count this string.
 - "as" appears once in words1, but does not appear in words2. We do not count this string.
 Thus, there are 2 strings that appear exactly once in each of the two arrays.

 Example 2:
 Input: words1 = ["b","bb","bbb"], words2 = ["a","aa","aaa"]
 Output: 0
 Explanation: There are no strings that appear in each of the two arrays.

 Example 3:
 Input: words1 = ["a","ab"], words2 = ["a","a","a","ab"]
 Output: 1
 Explanation: The only string that appears exactly once in each of the two arrays is "ab".
 */

extension ViewController {
    func solve18() {
        print("Setting up Challenge18 input!")

        let input = ["leetcode","is","amazing","as","is"]
        print("Input: \(input)")
        let output = Solution().countWords(input, ["amazing","leetcode","is"])
        print("Output: \(output)")
    }
}

private class Solution {
    func countWords(_ words1: [String], _ words2: [String]) -> Int {
        var hashMap: [String : [Int : Int]] = [:]

        for word in words1 {
            if var hashMapValue = hashMap[word] {
                if let cacheValue = hashMapValue[1] {
                    hashMapValue[1] = cacheValue + 1
                    hashMap[word] = hashMapValue
                } else {
                    hashMapValue[1] = 1
                    hashMap[word] = hashMapValue
                }
            } else {
                hashMap[word] = [1 : 1]
            }
        }

        for word in words2 {
            if var hashMapValue = hashMap[word] {
                if let cacheValue = hashMapValue[2] {
                    hashMapValue[2] = cacheValue + 1
                    hashMap[word] = hashMapValue
                } else {
                    hashMapValue[2] = 1
                    hashMap[word] = hashMapValue
                }
            } else {
                hashMap[word] = [2 : 1]
            }
        }

        var output = 0
        for (_, value) in hashMap {
            if let value1 = value[1],
            let value2 = value[2],
            value1 == 1, value2 == 1 {
                output += 1
            }
        }

        return output
    }
}

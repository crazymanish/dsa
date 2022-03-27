//
//  ViewController+Challenge30.swift
//  HashTable
//
//  Created by Manish Rathi on 27/03/2022.
//

import Foundation
/*
 1189. Maximum Number of Balloons
 https://leetcode.com/problems/maximum-number-of-balloons/
 Given a string text, you want to use the characters of text to form as many instances of the word "balloon" as possible.
 You can use each character in text at most once. Return the maximum number of instances that can be formed.

 Example 1:
 Input: text = "nlaebolko"
 Output: 1

 Example 2:
 Input: text = "loonbalxballpoon"
 Output: 2

 Example 3:
 Input: text = "leetcode"
 Output: 0
 */

extension ViewController {
    func solve30() {
        print("Setting up Challenge30 input!")

        let input = "loonbalxballpoon"
        print("Input: \(input)")
        let output = Solution().maxNumberOfBalloons(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func maxNumberOfBalloons(_ text: String) -> Int {
        var hashMap: [Character : Int] = [:]

        for char in text {
            let hashMapValue = hashMap[char] ?? 0
            hashMap[char] = hashMapValue + 1
        }

        var maxNumber = Int.max

        if let b = hashMap["b"],
        let a = hashMap["a"],
        let l = hashMap["l"],
        let o = hashMap["o"],
        let n = hashMap["n"] {
            maxNumber = min(maxNumber, b)
            maxNumber = min(maxNumber, a)
            maxNumber = min(maxNumber, l/2)
            maxNumber = min(maxNumber, o/2)
            maxNumber = min(maxNumber, n)
        } else {
            maxNumber = 0
        }

        return maxNumber
    }
}

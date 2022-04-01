//
//  ViewController+Challenge79.swift
//  HashTable
//
//  Created by Manish Rathi on 01/04/2022.
//

import Foundation
/*
 1807. Evaluate the Bracket Pairs of a String
 https://leetcode.com/problems/evaluate-the-bracket-pairs-of-a-string/
 You are given a string s that contains some bracket pairs, with each pair containing a non-empty key.
 For example, in the string "(name)is(age)yearsold", there are two bracket pairs that contain the keys "name" and "age".
 You know the values of a wide range of keys. This is represented by a 2D string array knowledge where each knowledge[i] = [keyi, valuei] indicates that key keyi has a value of valuei.
 You are tasked to evaluate all of the bracket pairs. When you evaluate a bracket pair that contains some key keyi, you will:
 Replace keyi and the bracket pair with the key's corresponding valuei.
 If you do not know the value of the key, you will replace keyi and the bracket pair with a question mark "?" (without the quotation marks).
 Each key will appear at most once in your knowledge. There will not be any nested brackets in s.

 Return the resulting string after evaluating all of the bracket pairs.

 Example 1:
 Input: s = "(name)is(age)yearsold", knowledge = [["name","bob"],["age","two"]]
 Output: "bobistwoyearsold"
 Explanation:
 The key "name" has a value of "bob", so replace "(name)" with "bob".
 The key "age" has a value of "two", so replace "(age)" with "two".

 Example 2:
 Input: s = "hi(name)", knowledge = [["a","b"]]
 Output: "hi?"
 Explanation: As you do not know the value of the key "name", replace "(name)" with "?".

 Example 3:
 Input: s = "(a)(a)(a)aaa", knowledge = [["a","yes"]]
 Output: "yesyesyesaaa"
 Explanation: The same key can appear multiple times.
 The key "a" has a value of "yes", so replace all occurrences of "(a)" with "yes".
 Notice that the "a"s not in a bracket pair are not evaluated.
 */

extension ViewController {
    func solve79() {
        print("Setting up Challenge79 input!")

        let input = "(name)is(age)yearsold"
        print("Input: \(input)")
        let output = Solution().evaluate(input, [["name","bob"],["age","two"]])
        print("Output: \(output)")
    }
}

private class Solution {
    func evaluate(_ s: String, _ knowledge: [[String]]) -> String {
        var hashMap: [String : String] = [:]
        for pair in knowledge { hashMap[pair[0]] = pair[1] }

        var outputString = ""

        var currentBracket = ""
        var shouldAppend = true
        for char in s.reversed() {
            if char == ")" {
                shouldAppend = false
                currentBracket = ""
            } else if char == "(" {
                shouldAppend = true
                let replacingString = hashMap[currentBracket] ?? "?"
                outputString = replacingString + outputString
            } else {
                currentBracket = String(char) + currentBracket
                if shouldAppend { outputString = String(char) + outputString }
            }
        }

        return outputString
    }
}

//
//  ViewController+Problem13.swift
//  Recursion
//
//  Created by Manish Rathi on 24/03/2022.
//

import Foundation
/*
 394. Decode String
 https://leetcode.com/problems/decode-string/
 Given an encoded string, return its decoded string.
 The encoding rule is: k[encoded_string], where the encoded_string inside the square brackets is being repeated exactly k times. Note that k is guaranteed to be a positive integer.
 You may assume that the input string is always valid; there are no extra white spaces, square brackets are well-formed, etc.
 Furthermore, you may assume that the original data does not contain any digits and that digits are only for those repeat numbers, k. For example, there will not be input like 3a or 2[4].

 Example 1:
 Input: s = "3[a]2[bc]"
 Output: "aaabcbc"

 Example 2:
 Input: s = "3[a2[c]]"
 Output: "accaccacc"

 Example 3:
 Input: s = "2[abc]3[cd]ef"
 Output: "abcabccdcdcdef"
 */

extension ViewController {
    func solve13() {
        print("Setting up Problem13 input!")

        var input = "3[a]2[bc]"
        print("Input: \(input)")
        var output = Solution().decodeString(input)
        print("Output: \(output)")

        input = "3[a2[c]]"
        print("Input: \(input)")
        output = Solution().decodeString(input)
        print("Output: \(output)")

        input = "2[abc]3[cd]ef"
        print("Input: \(input)")
        output = Solution().decodeString(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func decodeString(_ s: String) -> String {
        if s.isEmpty { return "" }

        let stack = Stack()
        var k = ""

        for char in s {
            let stringInfo = StringInfo(char)

            if stringInfo.intValue == nil {
                stack.push(StringInfo(k))
                k = ""
                handleNonIntStringInfo(stringInfo, stack)
            } else {
                k += stringInfo.string
            }
        }

        var output = ""
        while stack.isEmpty == false {
            output = stack.pop()!.string + output
        }

        return output
    }

    private func handleNonIntStringInfo(_ stringInfo: StringInfo, _ stack: Stack) {
        if stringInfo.isCloseBracket {
            var bracketString = ""
            while stack.top!.isOpenBracket == false {
                bracketString = stack.pop()!.string + bracketString
            }
            stack.pop()

            var calculatedString = ""
            let count = stack.pop()!.intValue!
            for _ in 0..<count {
                calculatedString += bracketString
            }
            stack.push(StringInfo(calculatedString))
        } else {
            stack.push(stringInfo)
        }
    }
}

private class StringInfo {
    let string: String

    init(_ char: Character) {
        self.string = String(char)
    }

    init(_ string: String) {
        self.string = string
    }

    var isOpenBracket: Bool { string == "[" }
    var isCloseBracket: Bool { string == "]" }
    var intValue: Int? { Int(string) }
}

private class Stack {
    private var array: [StringInfo] = []

    var isEmpty: Bool { array.isEmpty }

    var top: StringInfo? { array.last }

    func push(_ element: StringInfo) {
        array.append(element)
    }

    @discardableResult
    func pop() -> StringInfo? {
        if array.isEmpty { return nil }

        return array.removeLast()
    }
}

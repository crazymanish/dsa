//
//  ViewController+Problem1.swift
//  Day25
//
//  Created by Manish Rathi on 07/01/2022.
//

import Foundation
import dsa_reusable

/*
 https://www.geeksforgeeks.org/find-maximum-depth-nested-parenthesis-string/
 Find maximum depth of nested parenthesis in a string

 We are given a string having parenthesis like below
      “( ((X)) (((Y))) )”

 We need to find the maximum depth of balanced parenthesis, like 4 in the above example. Since ‘Y’ is surrounded by 4 balanced parentheses.
 If parenthesis is unbalanced then return -1.
 */

extension ViewController {
    func maxParenthesisDepth(inputString: String) {
        print("Input: \(inputString)")

        let stack = Stack<String>()
        var maxDepth = 0
        var currentDepth = 0

        for character in inputString {
            let characterString = character.asString

            if characterString == " " { continue }

            if characterString == "(" {
                maxDepth = max(maxDepth, currentDepth)
                currentDepth = 0
                stack.push(data: characterString)
            } else if characterString == ")" {
                currentDepth += 1

                if stack.isEmpty { return print("Ouput: -1 (unbalanced parenthesis)") }

                if stack.pop() == nil {
                    return print("Ouput: -1 (unbalanced parenthesis)")
                }
            }
        }

        if stack.isEmpty == false { return print("Ouput: -1 (unbalanced parenthesis)") }

        maxDepth = max(maxDepth, currentDepth)

        print("Ouput: \(maxDepth)")
    }
}

extension Character {
    var asString: String { String(self) }
}

//
//  ViewController+Problem1.swift
//  Day24
//
//  Created by Manish Rathi on 06/01/2022.
//

import Foundation
import dsa_reusable

/*
 https://www.geeksforgeeks.org/check-for-balanced-parentheses-in-an-expression/
 Check for Balanced Brackets in an expression

 Given an expression string exp, write a program to examine whether the pairs and the orders of “{“, “}”, “(“, “)”, “[“, “]” are correct in expression.
 Example:

 Input: exp = “[()]{}{[()()]()}”
 Output: Balanced

 Input: exp = “[(])”
 Output: Not Balanced
 */

extension ViewController {
    func validateBalancedBracketsExpression(inputString: String) {
        print("Input: \(inputString)")

        let stack = Stack<String>()

        for character in inputString {
            let characterString = character.asString
            let currentBracket = Bracket(rawValue: characterString)!

            if currentBracket.isOpening {
                stack.push(data: characterString)
            } else {
                let lastBracketString = stack.pop()!
                let lastBracket = Bracket(rawValue: lastBracketString)!

                if lastBracket.isMatch(closingBracket: currentBracket) == false {
                    print("Not Balanced")
                    return
                }
            }
        }

        if stack.isEmpty {
            print("Balanced")
        } else {
            print("Not Balanced")
        }
    }
}

extension Character {
    var asString: String {
        return String(self)
    }
}

enum Bracket: String {
    case smallOpening = "("
    case smallClosing = ")"
    case curlyOpening = "{"
    case curlyClosing = "}"
    case bigOpening = "["
    case bigClosing = "]"

    var isOpening: Bool {
        switch self {
        case .smallOpening, .curlyOpening, .bigOpening: return true
        default: break
        }

        return false
    }

    func isMatch(closingBracket: Bracket) -> Bool {
        switch self {
        case .smallOpening: if closingBracket == .smallClosing { return true }
        case .curlyOpening: if closingBracket == .curlyClosing { return true }
        case .bigOpening: if closingBracket == .bigClosing { return true }
        default: break
        }

        return false
    }
}

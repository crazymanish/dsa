//
//  ViewController+Problem2.swift
//  Day24
//
//  Created by Manish Rathi on 06/01/2022.
//

import Foundation
import dsa_reusable

/*
 https://www.geeksforgeeks.org/stack-set-4-evaluation-postfix-expression/
 Evaluation of Postfix Expression

 The Postfix notation is used to represent algebraic expressions. The expressions written in postfix form are evaluated faster compared to infix notation as parenthesis are not required in postfix.

 Example: “231*+9-“
 Evaluation => 2+(3*1)-9 => -4
 */

extension ViewController {
    func evaluatePostfixExpression(inputString: String) {
        print("Input: \(inputString)")

        let stack = Stack<Int>()

        for character in inputString {
            let characterString = character.asString

            if characterString.isOperator {
                let operand1 = stack.pop()!
                let operand2 = stack.pop()!
                let evaluatedPostfix: Int

                switch characterString {
                case "+": evaluatedPostfix = operand2 + operand1
                case "-": evaluatedPostfix = operand2 - operand1
                case "/": evaluatedPostfix = operand2 / operand1
                case "*": evaluatedPostfix = operand2 * operand1
                default: preconditionFailure("Wrong operator!")
                }

                stack.push(data: evaluatedPostfix)
            } else {
                let characterInt = characterString.asInt
                
                stack.push(data: characterInt)
            }
        }

        print("Output: \(stack.peek!)")
    }
}

extension String {
    var asInt: Int {
        return Int(self)!
    }

    var isOperator: Bool {
        switch self {
        case "+", "-", "/", "*": return true
        default: break
        }

        return false
    }
}

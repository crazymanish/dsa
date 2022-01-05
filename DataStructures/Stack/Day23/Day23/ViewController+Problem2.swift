//
//  ViewController+Problem2.swift
//  Day23
//
//  Created by Manish Rathi on 05/01/2022.
//

import Foundation
import dsa_reusable

/*
 https://www.geeksforgeeks.org/postfix-to-infix/
 Postfix to Infix

 Examples:

 Input : abc++
 Output : (a+(b+c))

 Input  : ab*c+
 Output : ((a*b)+c)
 */

extension ViewController {
    func postfixToInfix(inputString: String) {
        print("Input: \(inputString)")

        let stack = Stack<String>()

        for character in inputString {
            let characterString = character.asString

            if characterString.isOperator {
                let operand1 = stack.pop()!
                let operand2 = stack.pop()!
                let infix = "(" + operand2 + characterString + operand1 + ")"

                stack.push(data: infix)
            } else {
                stack.push(data: characterString)
            }
        }

        print("Output: \(stack.peek!)")
    }
}

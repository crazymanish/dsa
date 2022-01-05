//
//  ViewController+Problem1.swift
//  Day23
//
//  Created by Manish Rathi on 05/01/2022.
//

import Foundation
import dsa_reusable

/*
 https://www.geeksforgeeks.org/postfix-prefix-conversion/
 Postfix to Prefix Conversion

 Given a Postfix expression, convert it into a Prefix expression.
 Examples:

 Input :  Postfix : AB+CD-*
 Output : Prefix :  *+AB-CD
 Explanation : Postfix to Infix : (A+B) * (C-D)
               Infix to Prefix :  *+AB-CD

 Input :  Postfix : ABC/-AK/L-*
 Output : Prefix :  *-A/BC-/AKL
 Explanation : Postfix to Infix : ((A-(B/C))*((A/K)-L))
               Infix to Prefix :  *-A/BC-/AKL
 */

extension ViewController {
    func postfixToPrefix(inputString: String) {
        print("Input: \(inputString)")

        let stack = Stack<String>()

        for character in inputString {
            let characterString = character.asString

            if characterString.isOperator {
                let operand1 = stack.pop()!
                let operand2 = stack.pop()!
                let prefix = characterString + operand2 + operand1

                stack.push(data: prefix)
            } else {
                stack.push(data: characterString)
            }
        }

        print("Output: \(stack.peek!)")
    }
}

extension Character {
    var asString: String {
        return String(self)
    }
}

extension String {
    var isOperator: Bool {
        switch (self) {
        case "+", "-", "/", "*": return true
        default: break
        }

        return false
    }
}

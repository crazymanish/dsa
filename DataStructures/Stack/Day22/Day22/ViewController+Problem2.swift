//
//  ViewController+Problem2.swift
//  Day22
//
//  Created by Manish Rathi on 04/01/2022.
//

import Foundation
import dsa_reusable

/*
 https://www.geeksforgeeks.org/prefix-postfix-conversion/
 Prefix to Postfix Conversion

 Examples:

 Input :  Prefix :  *+AB-CD
 Output : Postfix : AB+CD-*
 Explanation : Prefix to Infix :  (A+B) * (C-D)
               Infix to Postfix :  AB+CD-*

 Input :  Prefix :  *-A/BC-/AKL
 Output : Postfix : ABC/-AK/L-*
 Explanation : Prefix to Infix :  (A-(B/C))*((A/K)-L)
               Infix to Postfix : ABC/-AK/L-*
 */

extension ViewController {
    func prefixToPostfix(inputString: String) {
        print("Input: \(inputString)")

        let stack = Stack<String>()

        for character in inputString.reversed() {
            let currentCharacterString = String(character)

            if currentCharacterString.isOperator {
                let operand2 = stack.pop()!
                let operand1 = stack.pop()!
                let postfix = operand2 + operand1 + currentCharacterString

                stack.push(data: postfix)
            } else {
                stack.push(data: currentCharacterString)
            }

            print("Output: \(stack.peek ?? "nil")")
        }
    }
}

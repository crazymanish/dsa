//
//  ViewController+Problem1.swift
//  Day22
//
//  Created by Manish Rathi on 04/01/2022.
//

import Foundation
import dsa_reusable

/*
 https://www.geeksforgeeks.org/prefix-infix-conversion/
 Prefix to Infix Conversion

 Examples:

 Input :  Prefix :  *+AB-CD
 Output : Infix : ((A+B)*(C-D))

 Input :  Prefix :  *-A/BC-/AKL
 Output : Infix : ((A-(B/C))*((A/K)-L))
 */

extension ViewController {
    func prefixToInfix(inputString: String) {
        print("Input: \(inputString)")

        let stack = Stack<String>()

        for character in inputString.reversed() {
            let currentCharacterString = String(character)

            if currentCharacterString.isOperator {
                let operand2 = stack.pop()!
                let operand1 = stack.pop()!
                let infix = "(" + operand2 + currentCharacterString + operand1 + ")"

                stack.push(data: infix)
            } else {
                stack.push(data: currentCharacterString)
            }

            print("Output: \(stack.peek ?? "nil")")
        }
    }
}

private extension String {
    var isOperator: Bool {
        switch (self) {
        case "+", "-", "/", "*": return true
        default: break
        }

        return false
    }
}

//
//  ViewController+Problem2.swift
//  Day26
//
//  Created by Manish Rathi on 08/01/2022.
//

import Foundation
import dsa_reusable

/*
 https://www.geeksforgeeks.org/reverse-number-using-stack/
 Reverse a number using stack

 Given a number , write a program to reverse this number using stack.
 Examples:
 Input : 365
 Output : 563

 Input : 6899
 Output : 9986
 */

extension ViewController {
    func reverse(inputNumber: Int) {
        print("Input: \(inputNumber)")

        let stack = Stack<Int>()

        // Insert digits into Stack
        var currentNumber = inputNumber
        while currentNumber != 0 {
            let digit = currentNumber % 10

            stack.push(data: digit)
            currentNumber /= 10
        }

        // reverse
        let outputNumber = stack.reverse

        print("Output: \(outputNumber)")
    }
}

extension Stack where T == Int {
    var reverse: Int {
        var output = 0
        var index = 1

        while isEmpty == false {
            output += index * pop()!
            index = index * 10
        }

        return output
    }
}

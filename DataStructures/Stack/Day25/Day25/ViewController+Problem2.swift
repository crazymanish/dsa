//
//  ViewController+Problem2.swift
//  Day25
//
//  Created by Manish Rathi on 07/01/2022.
//

import Foundation
import dsa_reusable

/*
 https://www.geeksforgeeks.org/stack-set-3-reverse-string-using-stack/
 Reverse a string using stack

 Given a string, reverse it using stack. For example “GeeksQuiz” should be converted to “ziuQskeeG”.
 */

extension ViewController {
    func reverse(inputString: String) {
        print("Input: \(inputString)")

        let stack = Stack<String>()

        for character in inputString {
            let characterString = character.asString
            stack.push(data: characterString)
        }

        var outputString = ""

        while stack.isEmpty == false {
            outputString += stack.pop()!
        }

        print("Output: \(outputString)")
    }
}

//
//  ViewController+Problem1.swift
//  Day26
//
//  Created by Manish Rathi on 08/01/2022.
//

import Foundation
import dsa_reusable

/*
 https://www.geeksforgeeks.org/reverse-individual-words/
 Reverse individual words

 Given a string str, we need to print reverse of individual words.
 Examples:
 Input : Hello World
 Output : olleH dlroW

 Input :  Geeks for Geeks
 Output : skeeG rof skeeG
 */

extension ViewController {
    func reverseWords(inputString: String) {
        print("Input: \(inputString)")

        let stack = Stack<String>()
        var outputString = ""

        for character in inputString {
            let characterString = character.asString

            if characterString == " " {
                outputString += stack.reverse
                outputString += characterString
            } else {
                stack.push(data: characterString)
            }
        }

        outputString += stack.reverse

        print("Output: \(outputString)")
    }
}

extension Stack where T == String {
    var reverse: String {
        var currentWord = ""

        while isEmpty == false {
            currentWord += pop()!
        }

        return currentWord
    }
}

extension Character {
    var asString: String { String(self) }
}

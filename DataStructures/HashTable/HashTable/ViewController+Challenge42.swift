//
//  ViewController+Challenge42.swift
//  HashTable
//
//  Created by Manish Rathi on 28/03/2022.
//

import Foundation
/*
 2094. Finding 3-Digit Even Numbers
 https://leetcode.com/problems/finding-3-digit-even-numbers/
 You are given an integer array digits, where each element is a digit. The array may contain duplicates.
 You need to find all the unique integers that follow the given requirements:
 The integer consists of the concatenation of three elements from digits in any arbitrary order.
 The integer does not have leading zeros.
 The integer is even.
 For example, if the given digits were [1, 2, 3], integers 132 and 312 follow the requirements.
 Return a sorted array of the unique integers.

 Example 1:
 Input: digits = [2,1,3,0]
 Output: [102,120,130,132,210,230,302,310,312,320]
 Explanation: All the possible integers that follow the requirements are in the output array.
 Notice that there are no odd integers or integers with leading zeros.

 Example 2:
 Input: digits = [2,2,8,8,2]
 Output: [222,228,282,288,822,828,882]
 Explanation: The same digit can be used as many times as it appears in digits.
 In this example, the digit 8 is used twice each time in 288, 828, and 882.

 Example 3:
 Input: digits = [3,7,5]
 Output: []
 Explanation: No even integers can be formed using the given digits.
 */

extension ViewController {
    func solve42() {
        print("Setting up Challenge42 input!")

        let input = [2,1,3,0]
        print("Input: \(input)")
        let output = Solution().findEvenNumbers(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func findEvenNumbers(_ digits: [Int]) -> [Int] {
        var digitsHashMap: [Int: Int] = [:]
        for digit in digits {
            let hashMapValue = digitsHashMap[digit] ?? 0
            digitsHashMap[digit] = hashMapValue + 1
        }

        var outputArray: [Int] = []

        for digit in 100...999 {
            if digit % 2 == 0 {
                let evenDigitHashMap = evenDigitHashMap(digit)
                var isFoundValidDigit = true
                for (key, value) in evenDigitHashMap {
                    if let value2 = digitsHashMap[key], value2 >= value {
                        isFoundValidDigit = true
                    } else {
                        isFoundValidDigit = false
                        break
                    }
                }

                if isFoundValidDigit {
                    outputArray.append(digit)
                }
            }
        }

        return outputArray.sorted()
    }

    private func evenDigitHashMap(_ digit: Int) -> [Int: Int] {
        var hashMap: [Int: Int] = [:]
        var mutatedDigit = digit

        let thirdNumber = mutatedDigit % 10
        mutatedDigit = mutatedDigit / 10

        let secondNumber = mutatedDigit % 10
        mutatedDigit = mutatedDigit / 10

        let firstNumber = mutatedDigit

        var hashMapValue = hashMap[firstNumber] ?? 0
        hashMap[firstNumber] = hashMapValue + 1

        hashMapValue = hashMap[secondNumber] ?? 0
        hashMap[secondNumber] = hashMapValue + 1

        hashMapValue = hashMap[thirdNumber] ?? 0
        hashMap[thirdNumber] = hashMapValue + 1

        return hashMap
    }
}

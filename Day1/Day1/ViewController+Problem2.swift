//
//  ViewController+Problem2.swift
//  Day1
//
//  Created by Manish Rathi on 14/12/2021.
//

import Foundation

// https://www.geeksforgeeks.org/program-for-array-rotation-continued-reversal-algorithm/
// Reversal algorithm for array rotation
// Write a function rotate(arr[], d, n) that rotates arr[] of size n by d elements.
//
// Input: 1 2 3 4 5 6 7
// Rotation of the above array by 2 will make array
// Output: 3 4 5 6 7 1 2

extension ViewController {
    func reversalRotate(inputArray: [String], digits: Int, size: Int) {
        print("Input: \(inputArray.joined(separator: ", "))")
        print("Rotation of the above array by \(digits)")

        var outputArray = reverse(inputArray: inputArray, startIndex: 0, endIndex: digits - 1)
        outputArray = reverse(inputArray: outputArray, startIndex: digits, endIndex: size - 1)
        outputArray = reverse(inputArray: outputArray, startIndex: 0, endIndex: size - 1)

        print("Output: \(outputArray.joined(separator: ", "))")
    }

    private func reverse(inputArray: [String], startIndex: Int, endIndex: Int) -> [String] {
        var outputArray = inputArray
        var startIndex = startIndex
        var endIndex = endIndex

        while (startIndex < endIndex) {
            let temp = inputArray[startIndex]
            outputArray[startIndex] = inputArray[endIndex]
            outputArray[endIndex] = temp

            startIndex += 1
            endIndex -= 1
        }

        return outputArray
    }
}

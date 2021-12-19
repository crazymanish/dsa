//
//  ViewController+Problem2.swift
//  Day6
//
//  Created by Manish Rathi on 19/12/2021.
//

import Foundation

/*
 https://www.geeksforgeeks.org/reversal-algorithm-right-rotation-array/
 Reversal algorithm for right rotation of an array

 Given an array, right rotate it by k elements.
 Example:
 Input: {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
        After K=3 right rotations
 Output: {8, 9, 10, 1, 2, 3, 4, 5, 6, 7}

 Input: arr[] = {121, 232, 33, 43, 5}
            k = 2
 Output: 43 5 121 232 33
 */

extension ViewController {
    func rightReverse(inputArray: [Int], size: Int, rotationCount: Int) {
        print("Input: \(inputArray.joined)")
        print("Right rotation reverse by \(rotationCount)")

        // Reverse all array
        // Reverse rotation count element
        // Reverse rest of the array
        var outputArray = rightReverse(inputArray: inputArray, startIndex: 0, endIndex: size - 1)
        outputArray = rightReverse(inputArray: outputArray, startIndex: 0, endIndex: rotationCount - 1)
        outputArray = rightReverse(inputArray: outputArray, startIndex: rotationCount, endIndex: size - 1)

        print("Output: \(outputArray.joined)")
    }

    private func rightReverse(inputArray: [Int], startIndex: Int, endIndex: Int) -> [Int] {
        var outputArray = inputArray
        var startIndex = startIndex
        var endIndex = endIndex

        while (startIndex < endIndex) {
            let temp = outputArray[startIndex]
            outputArray[startIndex] = outputArray[endIndex]
            outputArray[endIndex] = temp

            startIndex += 1
            endIndex -= 1
        }

        return outputArray
    }
}

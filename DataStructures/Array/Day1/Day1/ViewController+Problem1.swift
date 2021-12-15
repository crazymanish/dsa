//
//  ViewController+Problem1.swift
//  Day1
//
//  Created by Manish Rathi on 14/12/2021.
//

import Foundation

// https://www.geeksforgeeks.org/array-rotation/
// Write a function rotate(ar[], d, n) that rotates arr[] of size n by d elements.
//
// Input: 1 2 3 4 5 6 7
// Rotation of the above array by 2 will make array
// Output: 3 4 5 6 7 1 2

extension ViewController {
    func rotate(inputArray: [String], digits: Int, size: Int) {
        print("Input: \(inputArray.joined(separator: ", "))")
        print("Rotation of the above array by \(digits)")

        var outputArray: [String] = []

        for index in digits..<size {
            outputArray.append(inputArray[index])
        }

        for index in 0..<digits {
            outputArray.append(inputArray[index])
        }

        print("Output: \(outputArray.joined(separator: ", "))")
    }
}

//
//  ViewController+Problem2.swift
//  Day2
//
//  Created by Manish Rathi on 15/12/2021.
//

import Foundation

// https://www.geeksforgeeks.org/c-program-cyclically-rotate-array-one/
// Program to cyclically rotate an array by one
// Given an array, cyclically rotate the array clockwise by one.
//
// Input: 1 2 3 4 5 6 7
// Cyclically rotate the above array by 1 will make array
// Output: 7 1 2 3 4 5 6

extension ViewController {
    func cyclicallyRotateBy1(inputArray: [String], size: Int) {
        print("Input: \(inputArray.joined(separator: ", "))")

        var outputArray = inputArray
        let lastElement = outputArray[(size - 1)]

        for index in (1..<size).reversed() {
            outputArray[index] = outputArray[(index - 1)]
        }
        outputArray[0] = lastElement

        print("Output: \(outputArray.joined(separator: ", "))")
    }
}

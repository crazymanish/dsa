//
//  ViewController+Problem2.swift
//  Day4
//
//  Created by Manish Rathi on 17/12/2021.
//

import Foundation

/*
 https://www.geeksforgeeks.org/maximum-sum-iarri-among-rotations-given-array/
 https://www.youtube.com/watch?v=3YNs_Ggqb-Q
 Maximum sum of i*arr[i] among all rotations of a given array
 Given an array arr[] of n integers, find the maximum that maximizes the sum of the value of i*arr[i] where i varies from 0 to n-1.

 Input: arr[] = {8, 3, 1, 2}
 Output: 29
 Explanation: Lets look at all the rotations,
 {8, 3, 1, 2} = 8*0 + 3*1 + 1*2 + 2*3 = 11
 {3, 1, 2, 8} = 3*0 + 1*1 + 2*2 + 8*3 = 29
 {1, 2, 8, 3} = 1*0 + 2*1 + 8*2 + 3*3 = 27
 {2, 8, 3, 1} = 2*0 + 8*1 + 3*2 + 1*3 = 17

 Input: arr[] = {3, 2, 1}
 Output: 7
 Explanation: Lets look at all the rotations,
 {3, 2, 1} = 3*0 + 2*1 + 1*2 = 4
 {2, 1, 3} = 2*0 + 1*1 + 3*2 = 7
 {1, 3, 2} = 1*0 + 3*1 + 2*2 = 7
 */

extension ViewController {
    func maximumSum(inputArray: [Int], size: Int) {
        print("Input: \(inputArray.joined)")

        var sumOfAllElements = 0
        for index in 0..<size {
            sumOfAllElements += inputArray[index]
        }

        var initialSum = 0

        // Initial rotation
        for index in 0..<size {
            initialSum += index * inputArray[index]
        }
        print("Initial sum: \(initialSum)")

        // MaximumSum
        var maximumSum = initialSum

        // Rotate Array, calculate sum & update MaximumSum if needed
        // rotatedSum = initialSum - sumOfAllElements + inputArray[index-1] * size
        for index in 1..<size {
            let rotatedSum = initialSum - sumOfAllElements + inputArray[index-1] * size
            print("Next rotation sum: \(rotatedSum)")

            maximumSum = max(maximumSum, rotatedSum)
        }

        print("Output: \(maximumSum)")
    }
}

extension Array where Element == Int {
    var joined: String {
        let arrayAsString = map { String($0) }
        return arrayAsString.joined(separator: ", ")
    }
}

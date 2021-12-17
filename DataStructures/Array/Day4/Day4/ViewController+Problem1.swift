//
//  ViewController+Problem1.swift
//  Day4
//
//  Created by Manish Rathi on 17/12/2021.
//

import Foundation

/*
 https://www.geeksforgeeks.org/find-maximum-value-of-sum-iarri-with-only-rotations-on-given-array-allowed/
 Find maximum value of Sum( i*arr[i]) with only rotations on given array allowed

 Given an array, only rotation operation is allowed on array. We can rotate the array as many times as we want. Return the maximum possible summation of i*arr[i].

 Input: arr[] = {1, 20, 2, 10}
 Output: 72
 We can get 72 by rotating array twice.
 {2, 10, 1, 20}
 20*3 + 1*2 + 10*1 + 2*0 = 72

 Explanation: Lets look at all the rotations,
 {1, 20, 2, 10} = 1*0 + 20*1 + 2*2 + 10*3 = 54
 {20, 2, 10, 1} = 20*0 + 2*1 + 10*2 + 1*3 = 25
 {2, 10, 1, 20} = 2*0 + 10*1 + 1*2 + 20*3 = 72
 {10, 1, 20, 2} = 10*0 + 1*1 + 20*2 + 2*3 = 47

 Input: arr[] = {10, 1, 2, 3, 4, 5, 6, 7, 8, 9}
 Output: 330
 We can get 330 by rotating array 9 times.
 {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
 0*1 + 1*2 + 2*3 ... 9*10 = 330
 */

extension ViewController {
    func maximumRotatedSum(inputArray: [Int], size: Int) {
        print("Input: \(inputArray.joined)")

        var sumOfAllElements = 0
        for index in 0..<size {
            sumOfAllElements += inputArray[index]
        }

        var currentSum = 0

        // Initial rotation
        for index in 0..<size {
            currentSum += index * inputArray[index]
        }
        print("Initial sum: \(currentSum)")

        // MaximumSum
        var maximumSum = currentSum

        // Rotate Array, calculate sum & update MaximumSum if needed
        // currentSum = currentSum + sumOfAllElements - inputArray[size-index] * size
        for index in 1..<size {
            currentSum = currentSum + sumOfAllElements - inputArray[size-index] * size
            print("Next rotation sum: \(currentSum)")

            if currentSum > maximumSum { maximumSum = currentSum }
        }

        print("Output: \(maximumSum)")
    }
}

//
//  ViewController+Problem2.swift
//  Day8
//
//  Created by Manish Rathi on 21/12/2021.
//

import Foundation

/*
 https://www.geeksforgeeks.org/write-a-program-to-reverse-an-array-or-string/
 Write a program to reverse an array or string

 Given an array (or string), the task is to reverse the array/string.
 Examples :

 Input  : arr[] = {1, 2, 3}
 Output : arr[] = {3, 2, 1}

 Input :  arr[] = {4, 5, 1, 2}
 Output : arr[] = {2, 1, 5, 4}
 */

extension ViewController {
    func reverse(inputArray: [Int], size: Int) {
        print("Input: \(inputArray.joined)")

        var outputArray = inputArray
        var leftIndex = 0
        var rightIndex = size - 1

        while leftIndex < rightIndex {
            let tempElement = outputArray[leftIndex]
            outputArray[leftIndex] = outputArray[rightIndex]
            outputArray[rightIndex] = tempElement

            leftIndex += 1
            rightIndex -= 1
        }

        print("Output: \(outputArray.joined)")
    }
}

//
//  ViewController+Problem2.swift
//  Day7
//
//  Created by Manish Rathi on 20/12/2021.
//

import Foundation

/*
 https://www.geeksforgeeks.org/split-array-add-first-part-end/
 Split the array and add the first part to the end

 There is a given array and split it from a specified position, and move the first part of the array add to the end.
 Examples:

 Input : arr[] = {12, 10, 5, 6, 52, 36}
             k = 2
 Output : arr[] = {5, 6, 52, 36, 12, 10}
 Explanation : Split from index 2 and first
 part {12, 10} add to the end .

 Input : arr[] = {3, 1, 2}
            k = 1
 Output : arr[] = {1, 2, 3}
 Explanation : Split from index 1 and first
 part add to the end.
 */

extension ViewController {
    func splitAndMerge(inputArray: [Int], size: Int, splitIndex: Int) {
        print("Input: \(inputArray.joined)")
        print("Perform split from index \(splitIndex) and merge it to the end")

        var outputArray = inputArray

        for index in splitIndex..<size {
            let outputIndex = index - splitIndex
            outputArray[outputIndex] = inputArray[index]
        }

        for index in 0..<splitIndex {
            let outputIndex = size - splitIndex + index
            outputArray[outputIndex] = inputArray[index]
        }

        print("Output: \(outputArray.joined)")
    }
}

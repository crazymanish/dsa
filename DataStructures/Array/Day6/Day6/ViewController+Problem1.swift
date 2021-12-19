//
//  ViewController+Problem1.swift
//  Day6
//
//  Created by Manish Rathi on 19/12/2021.
//

import Foundation

/*
 https://www.geeksforgeeks.org/find-minimum-element-in-a-sorted-and-rotated-array/
 Find the minimum element in a sorted and rotated array

 A sorted array is rotated at some unknown point, find the minimum element in it.
 The following solution assumes that all elements are distinct.

 Examples:

 Input: {5, 6, 1, 2, 3, 4}
 Output: 1

 Input: {1, 2, 3, 4}
 Output: 1

 Input: {2, 1}
 Output: 1
 */

extension ViewController {
    func findMinimumElement(inputArray: [Int], size: Int) {
        print("Input: \(inputArray.joined)")

        let minimumElement = findMinimumElementUsingBinarySearch(inputArray: inputArray, low: 0, high: size - 1)

        print("Output: \(minimumElement)")
    }

    private func findMinimumElementUsingBinarySearch(inputArray: [Int], low: Int, high: Int) -> Int {
        // Base condition
        if low == high { return inputArray[low] } // Only one element

        // Find mid
        let mid = (low + high) / 2

        // Compare mid-1, mid, mid+1
        if mid > low && inputArray[(mid - 1)] > inputArray[mid] { return inputArray[mid] }
        if high > mid && inputArray[mid] > inputArray[(mid + 1)] { return inputArray[(mid + 1)] }

        // Bump low,high for next iteration
        if inputArray[high] > inputArray[mid] {
            return findMinimumElementUsingBinarySearch(inputArray: inputArray, low: low, high: mid - 1)
        } else {
            return findMinimumElementUsingBinarySearch(inputArray: inputArray, low: mid + 1, high: high)
        }
    }
}

extension Array where Element == Int {
    var joined: String {
        let arrayAsString = map { String($0) }
        return arrayAsString.joined(separator: ", ")
    }
}

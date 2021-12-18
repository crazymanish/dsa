//
//  ViewController+Problem1.swift
//  Day5
//
//  Created by Manish Rathi on 18/12/2021.
//

import Foundation

/*
 https://www.geeksforgeeks.org/find-rotation-count-rotated-sorted-array/
 Find the Rotation Count in Rotated Sorted array

 Consider an array of distinct numbers sorted in increasing order. The array has been rotated (clockwise) k number of times. Given such an array, find the value of k.

 Examples:
 Input : arr[] = {15, 18, 2, 3, 6, 12}
 Output: 2
 Explanation : Initial array must be {2, 3,
 6, 12, 15, 18}. We get the given array after
 rotating the initial array twice.

 Input : arr[] = {7, 9, 11, 12, 5}
 Output: 4

 Input: arr[] = {7, 9, 11, 12, 15};
 Output: 0

 # Solution1: O(n) Loop all elements
 # Solution2: O(logn) Binary search
 */

extension ViewController {
    func rotationCount(inputArray: [Int], size: Int) {
        print("Input: \(inputArray.joined)")

        let rotationCount = rotationCount(inputArray: inputArray, low: 0, high: size - 1)

        print("Output: \(rotationCount)")
    }

    private func rotationCount(inputArray: [Int], low: Int, high: Int) -> Int {
        // Base conditions
        if low > high { return 0 } // Array is not rotated at all

        if low == high { return low } // Array has only one element

        // Find mid
        let mid = (low + high) / 2

        // Check mid+1/mid-1 element
        if high > mid && inputArray[mid] > inputArray[mid + 1] { return mid + 1 }
        if mid > low && inputArray[mid - 1] > inputArray[mid] { return mid }

        // Bump low/high for next iteration
        if inputArray[high] > inputArray[mid] {
            return rotationCount(inputArray: inputArray, low: low, high: mid - 1)
        } else {
            return rotationCount(inputArray: inputArray, low: mid + 1, high: high)
        }
    }
}

extension Array where Element == Int {
    var joined: String {
        let arrayAsString = map { String($0) }
        return arrayAsString.joined(separator: ", ")
    }
}

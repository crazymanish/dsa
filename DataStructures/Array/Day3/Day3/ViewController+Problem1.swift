//
//  ViewController+Problem1.swift
//  Day3
//
//  Created by Manish Rathi on 16/12/2021.
//

import Foundation

// https://www.geeksforgeeks.org/search-an-element-in-a-sorted-and-pivoted-array/
// Search an element in a sorted and rotated array
// An element in a sorted array can be found in O(log n) time via binary search. But suppose we rotate an ascending order sorted array at some pivot unknown to you beforehand. So for instance, 1 2 3 4 5 might become 3 4 5 1 2. Devise a way to find an element in the rotated array in O(log n) time.
//
// Examples:
/*
 Input  : arr[] = {5, 6, 7, 8, 9, 10, 1, 2, 3};
          key = 3
 Output : Found at index 8

 Input  : arr[] = {5, 6, 7, 8, 9, 10, 1, 2, 3};
          key = 30
 Output : Not found

 Input : arr[] = {30, 40, 50, 10, 20}
         key = 10
 Output : Found at index 3
 */

extension ViewController {
    func findItemInSortedRotatedArray(inputArray: [Int], item: Int) {
        print("Input: \(inputArray.joined)")
        print("Searching item in the above array \(item)")

        let index = binarySearchRotate(inputArray: inputArray, item: item)

        if let index = index {
            print("Found at index \(index)")
        } else {
            print("Not found")
        }
    }

    private func binarySearchRotate(inputArray: [Int], item: Int) -> Int? {
        var lowIndex = 0
        var highIndex = inputArray.count - 1
        var midIndex = -1

        while lowIndex <= highIndex {
            midIndex = (lowIndex + highIndex) / 2

            if inputArray[midIndex] == item { return midIndex }

            let distanceFromLowIndex = abs(inputArray[lowIndex] - item)
            let distanceFromMidIndex = abs(inputArray[midIndex] - item)
            let distanceFromHighIndex = abs(inputArray[highIndex] - item)

            if distanceFromMidIndex < distanceFromLowIndex && distanceFromMidIndex < distanceFromHighIndex {
                if inputArray[midIndex] > item {
                    highIndex = midIndex - 1
                } else {
                    lowIndex = midIndex + 1
                }
            } else if distanceFromHighIndex > distanceFromLowIndex {
                highIndex = midIndex - 1
            } else {
                lowIndex = midIndex + 1
            }
        }

        return nil
    }
}

extension Array where Element == Int {
    var joined: String {
        let arrayAsString = map { String($0) }
        return arrayAsString.joined(separator: ", ")
    }
}

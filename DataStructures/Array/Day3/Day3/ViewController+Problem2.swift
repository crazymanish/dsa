//
//  ViewController+Problem2.swift
//  Day3
//
//  Created by Manish Rathi on 16/12/2021.
//

import Foundation

// https://www.geeksforgeeks.org/given-a-sorted-and-rotated-array-find-if-there-is-a-pair-with-a-given-sum/
// Given a sorted and rotated array, find if there is a pair with a given sum
// Given an array that is sorted and then rotated around an unknown point. Find if the array has a pair with a given sum ‘x’. It may be assumed that all elements in the array are distinct.
//
// Examples:
/*
 Input: arr[] = {11, 15, 6, 8, 9, 10}, x = 16
 Output: true
 There is a pair (6, 10) with sum 16

 Input: arr[] = {11, 15, 26, 38, 9, 10}, x = 35
 Output: true
 There is a pair (26, 9) with sum 35

 Input: arr[] = {11, 15, 26, 38, 9, 10}, x = 45
 Output: false
 There is no pair with sum 45.
 */

extension ViewController {
    struct Pair {
        let firstValue: Int
        let secondValue: Int
    }

    func findPairOfSumIn(inputArray: [Int], sum: Int) {
        print("Input: \(inputArray.joined)")
        print("Finding pair in the above array for sum \(sum)")

        let pair = findPair(inputArray: inputArray, size: inputArray.count, sum: sum)

        if let pair = pair {
            print("There is a pair (\(pair.firstValue), \(pair.secondValue)) with sum \(sum)")
        } else {
            print("There is no pair with sum \(sum).")
        }
    }

    private func findPair(inputArray: [Int], size: Int, sum: Int) -> Pair? {
        // Step1: Find Pivot element
        var pivot = -1

        for index in 0..<size {
            if inputArray[index] > inputArray[index + 1] {
                pivot = index
                break
            }
        }

        var minElementIndex = (pivot + 1) % size
        var maxElementIndex = pivot

        // Step2: Find min, max as Pair or move left/right
        while (minElementIndex != maxElementIndex) {
            let minElement = inputArray[minElementIndex]
            let maxElement = inputArray[maxElementIndex]

            if minElement + maxElement == sum {
                return .init(firstValue: minElement, secondValue: maxElement)
            }

            if minElement + maxElement < sum {
                minElementIndex = (minElementIndex + 1) % size
            } else {
                maxElementIndex = (size + maxElementIndex - 1) % size
            }
        }
        
        return nil
    }
}

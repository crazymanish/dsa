//
//  ViewController+Problem2.swift
//  Day5
//
//  Created by Manish Rathi on 18/12/2021.
//

import Foundation

/*
 https://www.geeksforgeeks.org/quickly-find-multiple-left-rotations-of-an-array/
 Quickly find multiple left rotations of an array

 Given an array of size n and multiple values around which we need to left rotate the array. How to quickly find multiple left rotations?

 Examples:
 Input : arr[] = {1, 3, 5, 7, 9}
         k1 = 1
         k2 = 3
         k3 = 4
         k4 = 6
 Output : 3 5 7 9 1
          7 9 1 3 5
          9 1 3 5 7
          3 5 7 9 1

 Input : arr[] = {1, 3, 5, 7, 9}
         k1 = 14
 Output : 9 1 3 5 7
 */

extension ViewController {
    func printRotation(inputArray: [Int], size: Int, rotationCount: Int) {
        print("Input: \(inputArray.joined)")
        print("Output: after \(rotationCount) rotation(s)")

        for index in rotationCount..<size + rotationCount {
            print(inputArray[index%size], terminator: ", ")
        }

        print("\n")
    }
}

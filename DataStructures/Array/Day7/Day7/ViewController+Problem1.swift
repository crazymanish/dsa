//
//  ViewController+Problem1.swift
//  Day7
//
//  Created by Manish Rathi on 20/12/2021.
//

import Foundation

/*
 https://www.geeksforgeeks.org/print-left-rotation-array/
 Print left rotation of array in O(n) time and O(1) space

 Given an array of size n and multiple values around which we need to left rotate the array. How to quickly print multiple left rotations?

 Examples :

 Input :
 arr[] = {1, 3, 5, 7, 9}
 k1 = 1
 k2 = 3
 k3 = 4
 k4 = 6
 Output :
 3 5 7 9 1
 7 9 1 3 5
 9 1 3 5 7
 3 5 7 9 1

 Input :
 arr[] = {1, 3, 5, 7, 9}
 k1 = 14
 Output :
 9 1 3 5 7
 */

extension ViewController {
    func printLeftRotation(inputArray: [Int], size: Int, noOfRotation: Int) {
        print("Input: \(inputArray.joined)")
        print("Output after \(noOfRotation) rotations")

        for index in noOfRotation..<(size+noOfRotation) {
            print(inputArray[index%size], terminator: ", ")
        }

        print("\n")
    }
}

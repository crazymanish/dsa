//
//  Problem2.swift
//  Day36
//
//  Created by Manish Rathi on 06/02/2022.
//

import Foundation
/*
 https://www.geeksforgeeks.org/find-the-nearest-smaller-numbers-on-left-side-in-an-array/
 Find the nearest smaller numbers on left side in an array

 Given an array of integers, find the nearest smaller number for every element such that the smaller element is on left side.

 Examples:

 Input:  arr[] = {1, 6, 4, 10, 2, 5}
 Output:         {_, 1, 1,  4, 1, 2}
 First element ('1') has no element on left side. For 6,
 there is only one smaller element on left side '1'.
 For 10, there are three smaller elements on left side (1,
 6 and 4), nearest among the three elements is 4.

 Input: arr[] = {1, 3, 0, 2, 5}
 Output:        {_, 1, _, 0, 2}
 Expected time complexity is O(n).
 */

class Problem2 {
  private let inputArray: [Int]

  init(inputArray: [Int]) {
    self.inputArray = inputArray
  }
}

extension Problem2: Solvable {
  func solve() {
    print("Input: \(inputArray)")

    let stack = Stack<Int>()
    var outputArray: [Int] = []

    for currentElement in inputArray {
      if let peekElement = stack.peekElement {
        if peekElement < currentElement {
          outputArray.append(peekElement)
        } else {
          while stack.isEmpty == false && stack.peekElement! >= currentElement {
            stack.pop()
          }

          if let peekElement = stack.peekElement, peekElement < currentElement {
            outputArray.append(peekElement)
          } else {
            outputArray.append(-1)
          }
        }
      } else {
        outputArray.append(-1)
      }

      stack.push(element: currentElement)
    }

    print("Output: \(outputArray)")
  }
}

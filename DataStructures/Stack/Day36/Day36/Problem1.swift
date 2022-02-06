//
//  Problem1.swift
//  Day36
//
//  Created by Manish Rathi on 06/02/2022.
//

import Foundation

/*
 https://www.geeksforgeeks.org/next-smaller-element/
 Next Smaller Element

 Given an array, print the Next Smaller Element (NSE) for every element. The NSE for an element x is the first smaller element on the right side of x in array. Elements for which no smaller element exist (on right side), consider NSE as -1.
 Examples:
 a) For any array, rightmost element always has NSE as -1.
 b) For an array which is sorted in increasing order, all elements have NSE as -1.

 c) For the input array [4, 8, 5, 2, 25}, the NSE for each element are as follows.
 Element         NSE
    4      -->    2
    8      -->    5
    5      -->    2
    2      -->   -1
    25     -->   -1

 d) For the input array [13, 7, 6, 12}, the next smaller elements for each element are as follows.
   Element        NSE
    13      -->    7
    7       -->    6
    6       -->   -1
    12      -->   -1
 */

class Stack<T> {
  private var array: [T] = []

  var isEmpty: Bool {
    return array.isEmpty
  }

  var peekElement: T? {
    return array.last
  }

  func push(element: T) {
    array.append(element)
  }

  func pop() {
    array.removeLast()
  }
}

protocol Solvable {
  func solve()
}

class Problem {
  private let inputArray: [Int]

  init(inputArray: [Int]) {
    self.inputArray = inputArray
  }
}

extension Problem: Solvable {
  func solve() {
    print("Input: \(inputArray)")

    let stack = Stack<Int>()
    var outputArray: [Int] = []

    for currentElement in inputArray.reversed() {
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

    outputArray = outputArray.reversed()
    print("Output: \(outputArray)")
  }
}

//
//  Problem2.swift
//  Day35
//
//  Created by Manish Rathi on 06/02/2022.
//

import Foundation

/*
 https://www.procoding.org/nearest-greater-to-left/
 Nearest greater to left

 Write a program to find the nearest greater element or next greater to the left of each element in an array.

 Example -
 Input: [4, 5, 2, 0]
 Output: [-1, -1, 5, 2]

 Input: [1, 6, 4, 10, 2, 5]
 Output: [-1, -1, 6, -1, 10, 10]
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
      if let peekElement = stack.peek {
        if peekElement > currentElement {
          outputArray.append(peekElement)
        } else {
          while stack.isEmpty == false && stack.peek! <= currentElement {
            stack.pop()
          }

          if let peekElement = stack.peek {
            if peekElement > currentElement {
              outputArray.append(peekElement)
            } else {
             outputArray.append(-1)
            }
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

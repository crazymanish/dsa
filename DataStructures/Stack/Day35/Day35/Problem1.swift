//
//  Problem1.swift
//  Day35
//
//  Created by Manish Rathi on 06/02/2022.
//

import Foundation
/*
 https://www.geeksforgeeks.org/next-greater-element/
 Next Greater Element

 Given an array, print the Next Greater Element (NGE) for every element. The Next greater Element for an element x is the first greater element on the right side of x in the array. Elements for which no greater element exist, consider the next greater element as -1.

 Examples:
 For an array, the rightmost element always has the next greater element as -1.
 For an array that is sorted in decreasing order, all elements have the next greater element as -1.

 For the input array [4, 5, 2, 25], the next greater elements for each element are as follows.
 Element       NGE
    4      -->   5
    5      -->   25
    2      -->   25
    25     -->   -1

 For the input array [13, 7, 6, 12}, the next greater elements for each element are as follows.
   Element        NGE
    13      -->    -1
    7       -->     12
    6       -->     12
    12      -->     -1
 */

 // MARK: - Stack
class Stack<T> {
  var array: [T] = []

  var isEmpty: Bool {
    return array.isEmpty
  }

  var count: Int {
    return array.count
  }

  var peek: T? {
    return array.last
  }

  func push(element: T) {
    array.append(element)
  }

  func pop() {
    array.removeLast()
  }
}

// MARK: - Problem solution
protocol Solvable {
  func solve()
}

class Problem1 {
   private let inputArray: [Int]

   init(inputArray: [Int]) {
     self.inputArray = inputArray
   }
 }

 extension Problem1: Solvable {
   func solve() {
     print("Input array: \(inputArray)")

     var outputArray: [Int] = []
     let stack = Stack<Int>()

     for item in inputArray.reversed() {
       if var peekElement = stack.peek {
         if peekElement > item {
           outputArray.append(peekElement)
         } else {
           while peekElement < item {
               stack.pop()

               if stack.isEmpty { break }
               peekElement = stack.peek!
           }

           if peekElement > item {
             outputArray.append(peekElement)
           } else {
             outputArray.append(-1)
           }
         }
       } else {
         outputArray.append(-1)
       }

       stack.push(element: item)
     }

    outputArray = outputArray.reversed()
    print("Output array: \(outputArray)")
   }
 }

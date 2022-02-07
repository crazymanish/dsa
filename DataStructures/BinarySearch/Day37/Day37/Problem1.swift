//
//  Problem1.swift
//  Day37
//
//  Created by Manish Rathi on 07/02/2022.
//

import Foundation
/*
 https://www.geeksforgeeks.org/binary-search/
 Binary Search

 Problem: Given a sorted array arr[] of n elements, write a function to search a given element x in arr[].

 Binary Search Approach: Binary Search is a searching algorithm used in a sorted array by repeatedly dividing the search interval in half. The idea of binary search is to use the information that the array is sorted and reduce the time complexity to O(Log n). The basic steps to perform Binary Search are:

 Begin with an interval covering the whole array.
 If the value of the search key is less than the item in the middle of the interval, narrow the interval to the lower half.
 Otherwise, narrow it to the upper half.
 Repeatedly check until the value is found or the interval is empty.
 */

protocol Solvable {
  func solve()
}

class Problem {
  private let inputArray: [Int]
  private let searchingElement: Int

  init(inputArray: [Int], searchingElement: Int) {
    self.inputArray = inputArray
    self.searchingElement = searchingElement
  }
}

extension Problem: Solvable {
  func solve() {
    print("Input: \(inputArray)")

    let itemFound = binarySearch(
      array: inputArray,
      searchingElement: searchingElement)

    print("Searching element \(searchingElement):=> \(itemFound)")
  }

  private func binarySearch(array: [Int], searchingElement: Int) -> Bool {
    var startIndex = 0
    var endIndex = array.count - 1

    while startIndex <= endIndex {
      let midIndex = startIndex + (endIndex - startIndex) / 2
      let midElement = array[midIndex]

      if midElement == searchingElement {
        return true
      } else {
        if midElement < searchingElement {
          startIndex = midIndex + 1
        } else {
          endIndex = midIndex - 1
        }
      }
    }

    return false
  }
}

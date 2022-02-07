//
//  Problem2.swift
//  Day37
//
//  Created by Manish Rathi on 07/02/2022.
//

import Foundation
/*
 https://www.geeksforgeeks.org/binary-search/
 Binary Search with REVERSE Array

 Problem: Given a sorted REVERSE array arr[] of n elements, write a function to search a given element x in arr[].
 */

class Problem2 {
  private let inputArray: [Int]
  private let searchingElement: Int

  init(inputArray: [Int], searchingElement: Int) {
    self.inputArray = inputArray
    self.searchingElement = searchingElement
  }
}

extension Problem2: Solvable {
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
          endIndex = midIndex - 1
        } else {
          startIndex = midIndex + 1
        }
      }
    }

    return false
  }
}

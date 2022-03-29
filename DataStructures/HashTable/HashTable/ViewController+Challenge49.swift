//
//  ViewController+Challenge49.swift
//  HashTable
//
//  Created by Manish Rathi on 29/03/2022.
//

import Foundation
/*
 2133. Check if Every Row and Column Contains All Numbers
 https://leetcode.com/problems/check-if-every-row-and-column-contains-all-numbers/
 An n x n matrix is valid if every row and every column contains all the integers from 1 to n (inclusive).
 Given an n x n integer matrix matrix, return true if the matrix is valid. Otherwise, return false.

 Example 1:
 Input: matrix = [[1,2,3],[3,1,2],[2,3,1]]
 Output: true
 Explanation: In this case, n = 3, and every row and column contains the numbers 1, 2, and 3.
 Hence, we return true.

 Example 2:
 Input: matrix = [[1,1,1],[1,2,3],[1,2,3]]
 Output: false
 Explanation: In this case, n = 3, but the first row and the first column do not contain the numbers 2 or 3.
 Hence, we return false.
 */

extension ViewController {
    func solve49() {
        print("Setting up Challenge49 input!")

        let input = [[1,2,3],[3,1,2],[2,3,1]]
        print("Input: \(input)")
        let output = Solution().checkValid(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func checkValid(_ matrix: [[Int]]) -> Bool {
        let n = matrix.count
        var isValid = true

        for i in 0..<n {
            var rowHashMap: [Int : Bool] = [:]
            var columnHashMap: [Int : Bool] = [:]

            for j in 0..<n {
                 rowHashMap[matrix[i][j]] = true
                 columnHashMap[matrix[j][i]] = true
            }

            for key in 1...n {
                if rowHashMap[key] == nil || columnHashMap[key] == nil {
                    isValid = false
                    break
                }
            }

            if isValid == false { break }

        }

        return isValid
    }
}

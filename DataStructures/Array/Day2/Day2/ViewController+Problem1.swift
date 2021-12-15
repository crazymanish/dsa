//
//  ViewController+Problem1.swift
//  Day2
//
//  Created by Manish Rathi on 15/12/2021.
//

import Foundation

// https://www.geeksforgeeks.org/block-swap-algorithm-for-array-rotation/
// Block swap algorithm for array rotation
// Write a function rotate(ar[], d, n) that rotates arr[] of size n by d elements.
//
// Input: 1 2 3 4 5 6 7
// Rotation of the above array by 2 will make array
// Output: 3 4 5 6 7 1 2

extension ViewController {
    func blockSwapRotation(inputArray: [String], rotateBy: Int, size: Int) {
        print("Input: \(inputArray.joined(separator: ", "))")
        print("Rotation of the above array by \(rotateBy)")

        var outputArray = inputArray

        if rotateBy == 0 || rotateBy == size {
            print("Nothing to rotate, Array elements are already in expected position!")
        } else {
            var block1Size = rotateBy
            var block2Size = size - rotateBy

            while block1Size != block2Size {
                if block1Size < block2Size {
                    outputArray.swapBlockElements(
                        block1StartingIndex: rotateBy - block1Size,
                        block2StartingIndex: rotateBy - block1Size + block2Size,
                        blockSize: block1Size
                    )

                    print("Rotation1: \(outputArray.joined(separator: ", "))")

                    block2Size = block2Size - block1Size
                }

                if block1Size > block2Size {
                    outputArray.swapBlockElements(
                        block1StartingIndex: rotateBy - block1Size,
                        block2StartingIndex: rotateBy,
                        blockSize: block2Size
                    )

                    print("Rotation2: \(outputArray.joined(separator: ", "))")

                    block1Size = block1Size - block2Size
                }
            }

            outputArray.swapBlockElements(
                block1StartingIndex: rotateBy - block1Size,
                block2StartingIndex: rotateBy,
                blockSize: block1Size
            )
        }

        print("Output: \(outputArray.joined(separator: ", "))")
    }
}

private extension Array {
    mutating func swapBlockElements(block1StartingIndex: Int, block2StartingIndex: Int, blockSize: Int) {
        for index in 0..<blockSize {
            let temp = self[block1StartingIndex + index]

            self[block1StartingIndex + index] = self[block2StartingIndex + index]
            self[block2StartingIndex + index] = temp
        }
    }
}

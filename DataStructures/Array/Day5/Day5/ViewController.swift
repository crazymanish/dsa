//
//  ViewController.swift
//  Day5
//
//  Created by Manish Rathi on 18/12/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("--------Problem 1--------")
        solution1()
        print("--------Problem 2--------")
        solution2()
    }

    private func solution1() {
        var inputArray = [15, 18, 2, 3, 6, 12]
        rotationCount(inputArray: inputArray, size: inputArray.count)

        inputArray = [7, 9, 11, 12, 5]
        rotationCount(inputArray: inputArray, size: inputArray.count)

        inputArray = [7, 9, 11, 12, 15]
        rotationCount(inputArray: inputArray, size: inputArray.count)
    }

    private func solution2() {
        var inputArray = [1, 3, 5, 7, 9]
        printRotation(inputArray: inputArray, size: inputArray.count, rotationCount: 1)
        printRotation(inputArray: inputArray, size: inputArray.count, rotationCount: 3)
        printRotation(inputArray: inputArray, size: inputArray.count, rotationCount: 4)
        printRotation(inputArray: inputArray, size: inputArray.count, rotationCount: 6)

        inputArray = [1, 3, 5, 7, 9]
        printRotation(inputArray: inputArray, size: inputArray.count, rotationCount: 14)
    }
}


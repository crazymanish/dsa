//
//  ViewController.swift
//  Day3
//
//  Created by Manish Rathi on 16/12/2021.
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
        var inputArray = [5, 6, 7, 8, 9, 10, 1, 2, 3]
        findItemInSortedRotatedArray(inputArray: inputArray, item: 3)

        inputArray = [5, 6, 7, 8, 9, 10, 1, 2, 3]
        findItemInSortedRotatedArray(inputArray: inputArray, item: 30)

        inputArray = [30, 40, 50, 10, 20]
        findItemInSortedRotatedArray(inputArray: inputArray, item: 10)
    }

    private func solution2() {
        var inputArray = [11, 15, 6, 8, 9, 10]
        findPairOfSumIn(inputArray: inputArray, sum: 16)

        inputArray = [11, 15, 26, 38, 9, 10]
        findPairOfSumIn(inputArray: inputArray, sum: 35)

        inputArray = [11, 15, 26, 38, 9, 10]
        findPairOfSumIn(inputArray: inputArray, sum: 45)
    }
}


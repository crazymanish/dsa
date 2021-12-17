//
//  ViewController.swift
//  Day4
//
//  Created by Manish Rathi on 17/12/2021.
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
        var inputArray = [1, 20, 2, 10]
        maximumRotatedSum(inputArray: inputArray, size: inputArray.count)

        inputArray = [10, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        maximumRotatedSum(inputArray: inputArray, size: inputArray.count)
    }

    private func solution2() {
        var inputArray = [8, 3, 1, 2]
        maximumSum(inputArray: inputArray, size: inputArray.count)

        inputArray = [3, 2, 1]
        maximumSum(inputArray: inputArray, size: inputArray.count)
    }
}


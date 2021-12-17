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

    private func solution1() {}

    private func solution2() {
        var inputArray = [8, 3, 1, 2]
        maximumSum(inputArray: inputArray, size: inputArray.count)

        inputArray = [3, 2, 1]
        maximumSum(inputArray: inputArray, size: inputArray.count)
    }
}


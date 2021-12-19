//
//  ViewController.swift
//  Day6
//
//  Created by Manish Rathi on 19/12/2021.
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
        var inputArray = [5, 6, 1, 2, 3, 4]
        findMinimumElement(inputArray: inputArray, size: inputArray.count)

        inputArray = [1, 2, 3, 4]
        findMinimumElement(inputArray: inputArray, size: inputArray.count)

        inputArray = [2, 1]
        findMinimumElement(inputArray: inputArray, size: inputArray.count)
    }

    private func solution2() {}
}


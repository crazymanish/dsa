//
//  ViewController.swift
//  Day13
//
//  Created by Manish Rathi on 26/12/2021.
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
        var inputArray = [1, 2, 3, 4, 5]
        findMiddleItem(inputArray: inputArray)

        inputArray = [1, 2, 3, 4, 5, 6]
        findMiddleItem(inputArray: inputArray)
    }

    private func solution2() {
        let inputArray = [1, 2, 1, 2, 1, 3, 1]
        occurrenceCount(inputArray: inputArray, item: 1)
    }
}


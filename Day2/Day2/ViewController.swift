//
//  ViewController.swift
//  Day2
//
//  Created by Manish Rathi on 15/12/2021.
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
        let inputArray = ["1", "2", "3", "4", "5", "6", "7"]
        blockSwapRotation(inputArray: inputArray, rotateBy: 2, size: inputArray.count)
    }

    private func solution2() {
//        let inputArray = ["1", "2", "3", "4", "5", "6", "7"]
//        reversalRotate(inputArray: inputArray, digits: 2, size: inputArray.count)
    }
}


//
//  ViewController.swift
//  Day27
//
//  Created by Manish Rathi on 09/01/2022.
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
        reverse(inputArray: [10, 20, 30, 40, 50, 60, 70, 80, 90, 100])
        reverse(inputArray: [1, 2, 3, 4, 5])
    }

    private func solution2() {
        reverseRecursive(inputArray: [5, 24, 9, 6, 8, 4, 1, 8, 3, 6])
        reverseRecursive(inputArray: [8, 7, 2, 5, 1])
    }
}

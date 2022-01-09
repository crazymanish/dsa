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
    }

    private func solution2() {}
}

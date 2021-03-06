//
//  ViewController.swift
//  Day35
//
//  Created by Manish Rathi on 06/02/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        problem1()
        problem2()
    }

    private func problem1() {
        print("Problem1: Next Greater Element")
        print("-----------------")

        var inputArray = [4, 5, 2, 25]
        var problem1 = Problem1(inputArray: inputArray)
        problem1.solve()

        print("-----------------")

        inputArray = [13, 7, 6, 12]
        problem1 = Problem1(inputArray: inputArray)
        problem1.solve()
    }

    private func problem2() {
        print("Problem2: Nearest greater to left")
        print("-----------------")

        var inputArray = [4, 5, 2, 0]
        var problem1 = Problem2(inputArray: inputArray)
        problem1.solve()

        print("-----------------")

        inputArray = [1, 6, 4, 10, 2, 5]
        problem1 = Problem2(inputArray: inputArray)
        problem1.solve()
    }
}

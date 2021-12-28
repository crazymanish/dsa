//
//  ViewController.swift
//  Day15
//
//  Created by Manish Rathi on 28/12/2021.
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
        var inputArray = ["R", "A", "D", "A", "R"]
        checkPalindromeLinkedList(inputArray: inputArray)

        inputArray = ["R", "A", "D", "A", "R", "!"]
        checkPalindromeLinkedList(inputArray: inputArray)

        inputArray = ["R", "A", "M", "A"]
        checkPalindromeLinkedList(inputArray: inputArray)
    }

    private func solution2() {}
}

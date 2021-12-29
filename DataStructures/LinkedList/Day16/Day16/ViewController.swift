//
//  ViewController.swift
//  Day16
//
//  Created by Manish Rathi on 29/12/2021.
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
        var inputArray = [11, 21, 11, 21, 43, 11, 60]
        removeDuplicateFromLinkedList(inputArray: inputArray)

        inputArray = [12, 11, 12, 21, 41, 43, 21]
        removeDuplicateFromLinkedList(inputArray: inputArray)
    }

    private func solution2() {}
}


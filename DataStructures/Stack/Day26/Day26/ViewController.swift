//
//  ViewController.swift
//  Day26
//
//  Created by Manish Rathi on 08/01/2022.
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
        reverseWords(inputString: "Hello World")
        reverseWords(inputString: "Geeks for Geeks")
    }

    private func solution2() {
        reverse(inputNumber: 365)
        reverse(inputNumber: 6899)
        reverse(inputNumber: 39997)
    }
}


//
//  ViewController.swift
//  Day23
//
//  Created by Manish Rathi on 05/01/2022.
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
        postfixToPrefix(inputString: "AB+CD-*")
        postfixToPrefix(inputString: "ABC/-AK/L-*")
    }

    private func solution2() {}
}

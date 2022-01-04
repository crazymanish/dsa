//
//  ViewController.swift
//  Day22
//
//  Created by Manish Rathi on 04/01/2022.
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
        prefixToInfix(inputString: "*+AB-CD")
        prefixToInfix(inputString: "*-A/BC-/AKL")
    }

    private func solution2() {
        prefixToPostfix(inputString: "*+AB-CD")
        prefixToPostfix(inputString: "*-A/BC-/AKL")
    }
}


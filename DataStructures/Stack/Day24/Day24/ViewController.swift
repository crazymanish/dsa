//
//  ViewController.swift
//  Day24
//
//  Created by Manish Rathi on 06/01/2022.
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
        validateBalancedBracketsExpression(inputString: "[()]{}{[()()]()}")
        validateBalancedBracketsExpression(inputString: "[(])")
    }

    private func solution2() {
        evaluatePostfixExpression(inputString: "231*+9-")
    }
}

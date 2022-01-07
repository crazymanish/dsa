//
//  ViewController.swift
//  Day25
//
//  Created by Manish Rathi on 07/01/2022.
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
        maxParenthesisDepth(inputString: "(((X))(((Y))))")
        maxParenthesisDepth(inputString: "( a(b) (c) (d(e(f)g)h) I (j(k)l)m)")
        maxParenthesisDepth(inputString: "( p((q)) ((s)t) )")
        maxParenthesisDepth(inputString: "")
        maxParenthesisDepth(inputString: "b) (c) ()")
        maxParenthesisDepth(inputString: "(b) ((c) ()")
    }

    private func solution2() {}
}

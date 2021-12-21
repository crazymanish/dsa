//
//  ViewController.swift
//  Day8
//
//  Created by Manish Rathi on 21/12/2021.
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

    private func solution1() {}

    private func solution2() {}
}

extension Array where Element == Int {
    var joined: String {
        let arrayAsString = map { String($0) }
        return arrayAsString.joined(separator: ", ")
    }
}

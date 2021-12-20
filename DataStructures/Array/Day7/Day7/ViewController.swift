//
//  ViewController.swift
//  Day7
//
//  Created by Manish Rathi on 20/12/2021.
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
        let inputArray = [1, 3, 5, 7, 9]

        printLeftRotation(inputArray: inputArray, size: 5, noOfRotation: 1)
        printLeftRotation(inputArray: inputArray, size: 5, noOfRotation: 3)
        printLeftRotation(inputArray: inputArray, size: 5, noOfRotation: 4)
        printLeftRotation(inputArray: inputArray, size: 5, noOfRotation: 6)
        printLeftRotation(inputArray: inputArray, size: 5, noOfRotation: 14)
    }

    private func solution2() {}
}

extension Array where Element == Int {
    var joined: String {
        let arrayAsString = map { String($0) }
        return arrayAsString.joined(separator: ", ")
    }
}

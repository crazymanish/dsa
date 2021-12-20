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

        printLeftRotation(inputArray: inputArray, size: inputArray.count, noOfRotation: 1)
        printLeftRotation(inputArray: inputArray, size: inputArray.count, noOfRotation: 3)
        printLeftRotation(inputArray: inputArray, size: inputArray.count, noOfRotation: 4)
        printLeftRotation(inputArray: inputArray, size: inputArray.count, noOfRotation: 6)
        printLeftRotation(inputArray: inputArray, size: inputArray.count, noOfRotation: 14)
    }

    private func solution2() {
        var inputArray = [12, 10, 5, 6, 52, 36]
        splitAndMerge(inputArray: inputArray, size: inputArray.count, splitIndex: 2)

        inputArray = [3, 1, 2]
        splitAndMerge(inputArray: inputArray, size: inputArray.count, splitIndex: 1)
    }
}

extension Array where Element == Int {
    var joined: String {
        let arrayAsString = map { String($0) }
        return arrayAsString.joined(separator: ", ")
    }
}

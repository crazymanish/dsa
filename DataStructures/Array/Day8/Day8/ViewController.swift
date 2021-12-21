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

    private func solution1() {
        var inputArray = [-1, -1, 6, 1, 9, 3, 2, -1, 4, -1]
        rearrange(inputArray: inputArray, size: inputArray.count)

        inputArray = [19, 7, 0, 3, 18, 15, 12, 6, 1, 8, 11, 10, 9, 5, 13, 16, 2, 14, 17, 4]
        rearrange(inputArray: inputArray, size: inputArray.count)
    }

    private func solution2() {
        var inputArray = [1, 2, 3]
        reverse(inputArray: inputArray, size: inputArray.count)

        inputArray = [4, 5, 1, 2]
        reverse(inputArray: inputArray, size: inputArray.count)
    }
}

extension Array where Element == Int {
    var joined: String {
        let arrayAsString = map { String($0) }
        return arrayAsString.joined(separator: ", ")
    }
}

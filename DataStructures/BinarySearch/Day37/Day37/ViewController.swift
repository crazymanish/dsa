//
//  ViewController.swift
//  Day37
//
//  Created by Manish Rathi on 07/02/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        problem1()
        problem2()
    }

    private func problem1() {
        print("\n\n-------------")
        print("Binary search")
        print("-------------")

        let inputArray = [1, 2, 3, 4, 5]
        var searchingElement = 4

        var problem = Problem(inputArray: inputArray, searchingElement: searchingElement)
        problem.solve()

        print("-------------")
        searchingElement = 10

        problem = Problem(inputArray: inputArray, searchingElement: searchingElement)
        problem.solve()
    }

    private func problem2() {
        print("\n\n-------------")
        print("Binary search with REVERSE array")
        print("-------------")

        let inputArray = [5, 4, 3, 2, 1]
        var searchingElement = 4

        var problem = Problem2(inputArray: inputArray, searchingElement: searchingElement)
        problem.solve()

        print("-------------")
        searchingElement = 10

        problem = Problem2(inputArray: inputArray, searchingElement: searchingElement)
        problem.solve()
    }
}


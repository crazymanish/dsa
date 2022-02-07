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
    }

    private func problem1() {
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
}


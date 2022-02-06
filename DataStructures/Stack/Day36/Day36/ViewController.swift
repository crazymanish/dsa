//
//  ViewController.swift
//  Day36
//
//  Created by Manish Rathi on 06/02/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        problem1()
    }

    private func problem1() {
        print("Next Smaller Element")
        print("--------------")

        var inputArray = [4, 8, 5, 2, 25]
        var problem = Problem(inputArray: inputArray)
        problem.solve()

        print("--------------")

        inputArray = [13, 7, 6, 12]
        problem = Problem(inputArray: inputArray)
        problem.solve()
    }
}


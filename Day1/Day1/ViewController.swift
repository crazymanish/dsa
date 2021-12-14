//
//  ViewController.swift
//  Day1
//
//  Created by Manish Rathi on 14/12/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        solution1()
    }

    private func solution1() {
        let inputArray = ["1", "2", "3", "4", "5", "6", "7"]
        rotate(inputArray: inputArray, digits: 2, size: inputArray.count)
    }
}


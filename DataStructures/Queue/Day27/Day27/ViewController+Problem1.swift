//
//  ViewController+Problem1.swift
//  Day27
//
//  Created by Manish Rathi on 09/01/2022.
//

import Foundation
import dsa_reusable

/*
 https://www.geeksforgeeks.org/reversing-a-queue/
 Reversing a Queue

 Give an algorithm for reversing a queue Q.
 Examples:
 Input :  Q = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
 Output : Q = [100, 90, 80, 70, 60, 50, 40, 30, 20, 10]

 Input : [1, 2, 3, 4, 5]
 Output : [5, 4, 3, 2, 1]
 */

extension ViewController {
    func reverse(inputArray: [Int]) {
        var queue = Queue<Int>()

        // Push data into Queue
        for data in inputArray {
            queue.enQueue(data: data)
        }

        print("Input:")
        queue.printQueue()

        queue.reverse()

        print("Output:")
        queue.printQueue()
    }
}

extension Queue where T == Int {
    mutating func reverse() {
        let stack = Stack<Int>()

        while isEmpty == false {
            stack.push(data: deQueue()!)
        }

        while stack.isEmpty == false {
            enQueue(data: stack.pop()!)
        }
    }
}

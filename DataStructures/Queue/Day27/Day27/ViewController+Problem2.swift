//
//  ViewController+Problem2.swift
//  Day27
//
//  Created by Manish Rathi on 09/01/2022.
//

import Foundation
import dsa_reusable

/*
 https://www.geeksforgeeks.org/reversing-queue-using-recursion/
 Reversing a queue using recursion

 Examples :
 Input : Q = [5, 24, 9, 6, 8, 4, 1, 8, 3, 6]
 Output : Q = [6, 3, 8, 1, 4, 8, 6, 9, 24, 5]

 Explanation : Output queue is the reverse of the input queue.

 Input : Q = [8, 7, 2, 5, 1]
 Output : Q = [1, 5, 2, 7, 8]

 Recursive Algorithm :
 - The pop element from the queue if the queue has elements otherwise return empty queue.
 - Call reverseQueue function for the remaining queue.
 - Push the popped element in the resultant reversed queue.
 */

extension ViewController {
    func reverseRecursive(inputArray: [Int]) {
        var queue = Queue<Int>()

        // Push data into Queue
        for data in inputArray {
            queue.enQueue(data: data)
        }

        print("Input:")
        queue.printQueue()

        queue.reverseRecursive()

        print("Output:")
        queue.printQueue()
    }
}

extension Queue where T == Int {
    mutating func reverseRecursive() {
        if isEmpty { return }

        let deletedItem = deQueue()!
        reverseRecursive()
        enQueue(data: deletedItem)
    }
}

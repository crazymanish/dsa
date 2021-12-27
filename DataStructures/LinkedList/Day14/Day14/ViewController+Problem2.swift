//
//  ViewController+Problem2.swift
//  Day14
//
//  Created by Manish Rathi on 27/12/2021.
//

import Foundation
import dsa_reusable

/*
 https://www.geeksforgeeks.org/find-length-of-loop-in-linked-list/
 Find length of loop in linked list

 Write a function detectAndCountLoop() that checks whether a given Linked List contains loop and if loop is present then returns count of nodes in loop. For example, the loop is present in below-linked list and length of the loop is 4. If the loop is not present, then the function should return 0.

 Solution: Floyd’s Cycle-Finding Algorithm
 Approach: This is the fastest method and has been described below:

 Traverse linked list using two pointers.
 Move one pointer(slow_p) by one and another pointer(fast_p) by two.
 If these pointers meet at the same node then there is a loop. If pointers do not meet then linked list doesn’t have a loop.

 Find the common point in the loop by using the Floyd’s Cycle detection algorithm
 Store the pointer in a temporary variable and keep a count = 0
 Traverse the linked list until the same node is reached again and increase the count while moving to next node.
 Print the count as length of loop
 */

extension ViewController {
    func findLinkedListLoopCount() {
        let inputArray = [1, 2, 3, 4]
        let singlyLinkedList = SinglyLinkedList<Int>()

        for item in inputArray.reversed() {
            singlyLinkedList.insertAtStart(data: item)
        }

        print("Input: \(singlyLinkedList.asArray)")

        print("Creating loop in linked list, connecting last node with head")
        singlyLinkedList.head?.nextNode?.nextNode?.nextNode?.nextNode = singlyLinkedList.head

        let loopCount = loopCount(linkedList: singlyLinkedList)
        print("Loop count: \(loopCount)")
    }

    private func loopCount(linkedList: SinglyLinkedList<Int>) -> Int {
        if linkedList.isEmpty { return 0 }

        var slowPointer = linkedList.head
        var fastPointer = linkedList.head?.nextNode

        while slowPointer != nil {
            if slowPointer?.data == fastPointer?.data {
                return countLoop(node: slowPointer)
            }

            slowPointer = slowPointer?.nextNode
            fastPointer = fastPointer?.nextNode?.nextNode
        }

        return 0
    }

    private func countLoop(node: SinglyLinkedListNode<Int>?) -> Int {
        var counter = 1

        var tempNode = node
        while tempNode?.nextNode?.data != node?.data {
            tempNode = tempNode?.nextNode
            counter += 1
        }

        return counter
    }
}

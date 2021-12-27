//
//  ViewController+Problem1.swift
//  Day14
//
//  Created by Manish Rathi on 27/12/2021.
//

import Foundation
import dsa_reusable

/*
 https://www.geeksforgeeks.org/detect-loop-in-a-linked-list/
 Detect loop in a linked list

 Given a linked list, check if the linked list has loop or not. Below diagram shows a linked list with a loop.

 Solution: Floyd’s Cycle-Finding Algorithm
 Approach: This is the fastest method and has been described below:

 Traverse linked list using two pointers.
 Move one pointer(slow_p) by one and another pointer(fast_p) by two.
 If these pointers meet at the same node then there is a loop. If pointers do not meet then linked list doesn’t have a loop.
 */

extension ViewController {
    func detectLinkedListLoop() {
        let inputArray = [1, 2, 3, 4]
        let singlyLinkedList = SinglyLinkedList<Int>()

        for item in inputArray.reversed() {
            singlyLinkedList.insertAtStart(data: item)
        }

        print("Input: \(singlyLinkedList.asArray)")

        print("Creating loop in linked list, connecting last node with head")
        singlyLinkedList.head?.nextNode?.nextNode?.nextNode?.nextNode = singlyLinkedList.head

        let hasLoop = hasLoop(linkedList: singlyLinkedList)

        if hasLoop {
            print("Loop found!")
        } else {
            print("No loop!")
        }
    }

    private func hasLoop(linkedList: SinglyLinkedList<Int>) -> Bool {
        if linkedList.isEmpty { return false }

        var slowPointer = linkedList.head
        var fastPointer = linkedList.head?.nextNode

        while slowPointer != nil {
            if slowPointer?.data == fastPointer?.data { return true }

            slowPointer = slowPointer?.nextNode
            fastPointer = fastPointer?.nextNode?.nextNode
        }

        return false
    }
}

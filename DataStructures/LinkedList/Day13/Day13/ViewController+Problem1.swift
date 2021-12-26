//
//  ViewController+Problem1.swift
//  Day13
//
//  Created by Manish Rathi on 26/12/2021.
//

import Foundation
import dsa_reusable

/*
 https://www.geeksforgeeks.org/write-a-c-function-to-print-the-middle-of-the-linked-list/
 Find the middle of a given linked list

 Given a singly linked list, find the middle of the linked list. For example, if the given linked list is 1->2->3->4->5 then the output should be 3.
 If there are even nodes, then there would be two middle nodes, we need to print the second middle element. For example, if given linked list is 1->2->3->4->5->6 then the output should be 4.


 Method 1:
 Traverse the whole linked list and count the no. of nodes. Now traverse the list again till count/2 and return the node at count/2.

 Method 2:
 Traverse linked list using two pointers. Move one pointer by one and the other pointers by two. When the fast pointer reaches the end slow pointer will reach the middle of the linked list.
 */

extension ViewController {
    func findMiddleItem(inputArray: [Int]) {
        let singlyLinkedList = SinglyLinkedList<Int>()

        for item in inputArray.reversed() {
            singlyLinkedList.insertAtStart(data: item)
        }

        print("Input: \(singlyLinkedList.asArray)")

        let middleItem = findLinkedListMiddleItem(linkedList: singlyLinkedList)
        print("Output: \(middleItem)")
    }

    private func findLinkedListMiddleItem(linkedList: SinglyLinkedList<Int>) -> Int {
        if linkedList.count == 0 { return -1 }

        // Traverse linked list using two pointers. Move one pointer by one and the other pointers by two. When the fast pointer reaches the end slow pointer will reach the middle of the linked list.
        var slowPointer = linkedList.head
        var fastPointer = linkedList.head

        while fastPointer?.nextNode != nil {
            slowPointer = slowPointer?.nextNode
            fastPointer = fastPointer?.nextNode?.nextNode
        }

        return slowPointer!.data
    }
}

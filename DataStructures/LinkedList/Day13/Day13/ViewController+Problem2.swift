//
//  ViewController+Problem2.swift
//  Day13
//
//  Created by Manish Rathi on 26/12/2021.
//

import Foundation
import dsa_reusable

/*
 https://www.geeksforgeeks.org/write-a-function-that-counts-the-number-of-times-a-given-int-occurs-in-a-linked-list/
 Write a function that counts the number of times a given int occurs in a Linked List

 Given a singly linked list and a key, count the number of occurrences of the given key in the linked list. For example, if the given linked list is 1->2->1->2->1->3->1 and the given key is 1, then the output should be 4.
 */

extension ViewController {
    func occurrenceCount(inputArray: [Int], item: Int) {
        let singlyLinkedList = SinglyLinkedList<Int>()

        for item in inputArray.reversed() {
            singlyLinkedList.insertAtStart(data: item)
        }

        print("Input: \(singlyLinkedList.asArray)")
        print("Occurrence count for: \(item)")

        let occurrenceCount = occurrenceCount(linkedList: singlyLinkedList, item: item)
        print("Output: \(occurrenceCount)")
    }

    private func occurrenceCount(linkedList: SinglyLinkedList<Int>, item: Int) -> Int {
        if linkedList.count == 0 { return 0 }

        var occurrenceCounter = 0
        var currentNode = linkedList.head

        while currentNode != nil {
            if currentNode?.data == item {
                occurrenceCounter += 1
            }

            currentNode = currentNode?.nextNode
        }

        return occurrenceCounter
    }
}

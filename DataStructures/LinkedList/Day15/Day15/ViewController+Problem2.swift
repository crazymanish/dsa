//
//  ViewController+Problem2.swift
//  Day15
//
//  Created by Manish Rathi on 28/12/2021.
//

import Foundation
import dsa_reusable

/*
 https://www.geeksforgeeks.org/remove-duplicates-from-a-sorted-linked-list/
 Remove duplicates from a sorted linked list

 Write a function that takes a list sorted in non-decreasing order and deletes any duplicate nodes from the list. The list should only be traversed once.

 For example if the linked list is 11->11->11->21->43->43->60 then removeDuplicates() should convert the list to 11->21->43->60.
 */

extension ViewController {
    func deleteDuplicateFromSortedLinkedList(inputArray: [Int]) {
        let singlyLinkedList = SinglyLinkedList<Int>()

        for item in inputArray.reversed() {
            singlyLinkedList.insertAtStart(data: item)
        }

        print("Input: \(singlyLinkedList.asArray)")

        var currentPointer = singlyLinkedList.head

        while currentPointer != nil {
            var tempPointer = currentPointer?.nextNode

            while tempPointer != nil && tempPointer?.data == currentPointer?.data {
                tempPointer = tempPointer?.nextNode
            }

            currentPointer?.nextNode = tempPointer
            currentPointer = currentPointer?.nextNode
        }

        print("Output: \(singlyLinkedList.asArray)")
    }
}

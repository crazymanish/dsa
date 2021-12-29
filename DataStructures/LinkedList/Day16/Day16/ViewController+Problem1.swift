//
//  ViewController+Problem1.swift
//  Day16
//
//  Created by Manish Rathi on 29/12/2021.
//

import Foundation
import dsa_reusable

/*
 https://www.geeksforgeeks.org/remove-duplicates-from-an-unsorted-linked-list/
 Remove duplicates from an unsorted linked list

 Write a removeDuplicates() function that takes a list and deletes any duplicate nodes from the list. The list is not sorted.
 For example if the linked list is 12->11->12->21->41->43->21 then removeDuplicates() should convert the list to 12->11->21->41->43.

 METHOD 3 (Use Hashing)
 We traverse the link list from head to end. For every newly encountered element, we check whether it is in the hash table: if yes, we remove it; otherwise we put it in the hash table.
 */

extension ViewController {
    func removeDuplicateFromLinkedList(inputArray: [Int]) {
        let singlyLinkedList = SinglyLinkedList<Int>()
        var hashTable = [Int: Bool]()

        for item in inputArray.reversed() {
            singlyLinkedList.insertAtStart(data: item)
        }

        print("Input: \(singlyLinkedList.asArray)")

        guard singlyLinkedList.isEmpty == false else {
            print("Output: Linked list is empty, no duplicate found.")
            return
        }

        var previousPointer: SinglyLinkedListNode<Int>? = nil
        var currentPointer = singlyLinkedList.head
        hashTable[currentPointer!.data] = true

        while currentPointer != nil {
            let nodeData = currentPointer!.data

            if hashTable[nodeData] ?? false {
                previousPointer?.nextNode = currentPointer?.nextNode
            } else {
                hashTable[nodeData] = true
                previousPointer = currentPointer
            }

            currentPointer = currentPointer?.nextNode
        }

        print("Output: \(singlyLinkedList.asArray)")
    }
}

//
//  ViewController+Problem2.swift
//  Day16
//
//  Created by Manish Rathi on 29/12/2021.
//

import Foundation
import dsa_reusable

/*
 https://www.geeksforgeeks.org/move-last-element-to-front-of-a-given-linked-list/
 Move last element to front of a given Linked List

 Write a function that moves the last element to the front in a given Singly Linked List. For example, if the given Linked List is 1->2->3->4->5, then the function should change the list to 5->1->2->3->4.

 Algorithm:
 Traverse the list till last node. Use two pointers: one to store the address of last node and other for address of second last node. After the end of loop do following operations.
 i) Make second last as last (secLast->next = NULL).
 ii) Set next of last as head (last->next = *head_ref).
 iii) Make last as head ( *head_ref = last)
 */

extension ViewController {
    func moveLastItemToFrontInLinkedList(inputArray: [Int]) {
        let singlyLinkedList = SinglyLinkedList<Int>()

        for item in inputArray.reversed() {
            singlyLinkedList.insertAtStart(data: item)
        }

        print("Input: \(singlyLinkedList.asArray)")

        guard singlyLinkedList.isEmpty == false else {
            print("Output: Linked list is empty, nothing to move.")
            return
        }

        var previousPointer: SinglyLinkedListNode<Int>? = nil
        var currentPointer = singlyLinkedList.head

        // Loop to find SecondLast(previousPointer) & Last(currentPointer) Nodes
        while currentPointer?.nextNode != nil {
            previousPointer = currentPointer
            currentPointer = currentPointer?.nextNode
        }

        // Make SecondLast(previousPointer).nextNode as nil to make it last node of List
        previousPointer?.nextNode = nil

        // Insert Last(currentPointer) at start (head)
        currentPointer?.nextNode = singlyLinkedList.head
        singlyLinkedList.head = currentPointer

        print("Output: \(singlyLinkedList.asArray)")
    }
}

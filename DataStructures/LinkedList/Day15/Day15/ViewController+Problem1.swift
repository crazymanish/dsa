//
//  ViewController+Problem1.swift
//  Day15
//
//  Created by Manish Rathi on 28/12/2021.
//

import Foundation
import dsa_reusable

/*
 https://www.geeksforgeeks.org/function-to-check-if-a-singly-linked-list-is-palindrome/
 Function to check if a singly linked list is palindrome

 Given a singly linked list of characters, write a function that returns true if the given list is a palindrome, else false.

 Example: RADAR
 */

extension ViewController {
    func checkPalindromeLinkedList(inputArray: [String]) {
        let singlyLinkedList = SinglyLinkedList<String>()

        for item in inputArray.reversed() {
            singlyLinkedList.insertAtStart(data: item)
        }

        print("Input: \(singlyLinkedList.asArray)")

        let isPalindrome = isPalindrome(linkedList: singlyLinkedList)

        if isPalindrome {
            print("Linked list is palindrome!")
        } else {
            print("Linked list is not palindrome!")
        }
    }

    /*
     - Find the middle element using Slow & Fast pointer.
     - Match first half (in reversed) with second half.
     */
    private func isPalindrome(linkedList: SinglyLinkedList<String>) -> Bool {
        if linkedList.isEmpty { return false }
        if linkedList.count == 1 { return true }

        var slowPointer = linkedList.head
        var fastPointer = linkedList.head

        let firstHalfLinkedList = SinglyLinkedList<String>()

        while fastPointer?.nextNode != nil {
            firstHalfLinkedList.insertAtStart(data: slowPointer!.data)

            slowPointer = slowPointer?.nextNode
            fastPointer = fastPointer?.nextNode?.nextNode
        }

        // Move slow-pointer to the next element from Middle -- to make it ready to compare.
        slowPointer = slowPointer?.nextNode
        var firstHalfPointer = firstHalfLinkedList.head

        while slowPointer != nil {
            if firstHalfPointer?.data != slowPointer?.data {
                return false
            }

            firstHalfPointer = firstHalfPointer?.nextNode
            slowPointer = slowPointer?.nextNode
        }

        if firstHalfPointer == nil {
            return true
        } else {
            return false
        }
    }
}

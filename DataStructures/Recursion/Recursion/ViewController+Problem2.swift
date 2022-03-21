//
//  ViewController+Problem2.swift
//  Recursion
//
//  Created by Manish Rathi on 21/03/2022.
//

import Foundation
/*
 206. Reverse Linked List
 https://leetcode.com/problems/reverse-linked-list/

 Given the head of a singly linked list, reverse the list, and return the reversed list.
 Example 1:
 Input: head = [1,2,3,4,5]
 Output: [5,4,3,2,1]

 Example 2:
 Input: head = [1,2]
 Output: [2,1]

 Example 3:
 Input: head = []
 Output: []
 */

extension ViewController {
    func solve2() {
        print("Setting up Problem2 input!")

        let head = ListNode(1)
        head.next = ListNode(2)
        head.next?.next = ListNode(3)
        head.next?.next?.next = ListNode(4)
        head.next?.next?.next?.next = ListNode(5)

        print("Input: \(head.val)")
        var output = Solution().reverseList(head)

        while output != nil {
            print("Output: \(output!.val)")
            output = output?.next
        }
    }
}

private class ListNode {
    var val: Int
    var next: ListNode?
    init() { self.val = 0; self.next = nil; }
    init(_ val: Int) { self.val = val; self.next = nil; }
    init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

private class Solution {
    func reverseList(_ head: ListNode?) -> ListNode? {
        return reverseList(head, nil)
    }

    private func reverseList(_ current: ListNode?, _ previous: ListNode?) -> ListNode? {
        if current == nil { return previous }

        let next = current?.next
        current?.next = previous

        return reverseList(next, current)
    }
}

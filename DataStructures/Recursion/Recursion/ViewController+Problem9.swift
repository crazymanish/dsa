//
//  ViewController+Problem9.swift
//  Recursion
//
//  Created by Manish Rathi on 22/03/2022.
//

import Foundation
/*
 203. Remove Linked List Elements
 https://leetcode.com/problems/remove-linked-list-elements/
 Given the head of a linked list and an integer val, remove all the nodes of the linked list that has Node.val == val, and return the new head.

 Example 1:
 Input: head = [1,2,6,3,4,5,6], val = 6
 Output: [1,2,3,4,5]

 Example 2:
 Input: head = [], val = 1
 Output: []

 Example 3:
 Input: head = [7,7,7,7], val = 7
 Output: []
 */

extension ViewController {
    func solve9() {
        print("Setting up Problem9 input!")

        let head = ListNode(1)
        head.next = ListNode(2)
        head.next?.next = ListNode(6)
        head.next?.next?.next = ListNode(3)
        head.next?.next?.next?.next = ListNode(6)

        print("Input: \(head.val)")
        var output = Solution().removeElements(head, 6)

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
    func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        if head == nil { return nil }

        head?.next = removeElements(head?.next, val)

        return head!.val == val ? head?.next : head
    }
}

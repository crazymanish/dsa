//
//  ViewController+Problem4.swift
//  Recursion
//
//  Created by Manish Rathi on 21/03/2022.
//

import Foundation
/*
 21. Merge Two Sorted Lists
 https://leetcode.com/problems/merge-two-sorted-lists/

 You are given the heads of two sorted linked lists list1 and list2.
 Merge the two lists in a one sorted list. The list should be made by splicing together the nodes of the first two lists.
 Return the head of the merged linked list.

 Example 1:
 Input: list1 = [1,2,4], list2 = [1,3,4]
 Output: [1,1,2,3,4,4]

 Example 2:
 Input: list1 = [], list2 = []
 Output: []

 Example 3:
 Input: list1 = [], list2 = [0]
 Output: [0]
 */

extension ViewController {
    func solve4() {
        print("Setting up Problem4 input!")

        let head = ListNode(1)
        head.next = ListNode(2)
        head.next?.next = ListNode(3)

        print("Input: \(head.val)")
        var output = Solution().mergeTwoLists(head, head)

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
    func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        if list1 == nil && list2 == nil { return nil }
        if list1 == nil { return list2 }
        if list2 == nil { return list1 }

        guard let list1Node = list1, let list2Node = list2 else { return nil }

        if list1Node.val < list2Node.val {
            return ListNode(list1Node.val, mergeTwoLists(list1Node.next, list2Node))
        } else {
            return ListNode(list2Node.val, mergeTwoLists(list1Node, list2Node.next))
        }
    }
}

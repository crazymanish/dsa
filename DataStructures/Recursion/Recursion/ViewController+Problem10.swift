//
//  ViewController+Problem10.swift
//  Recursion
//
//  Created by Manish Rathi on 22/03/2022.
//

import Foundation
/*
 2. Add Two Numbers
 https://leetcode.com/problems/add-two-numbers/
 You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order, and each of their nodes contains a single digit. Add the two numbers and return the sum as a linked list.
 You may assume the two numbers do not contain any leading zero, except the number 0 itself.

 Example 1:
 Input: l1 = [2,4,3], l2 = [5,6,4]
 Output: [7,0,8]
 Explanation: 342 + 465 = 807.

 Example 2:
 Input: l1 = [0], l2 = [0]
 Output: [0]

 Example 3:
 Input: l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
 Output: [8,9,9,9,0,0,0,1]
 */

extension ViewController {
    func solve10() {
        print("Setting up Problem10 input!")

        let head = ListNode(1)
        head.next = ListNode(2)
        head.next?.next = ListNode(6)
        head.next?.next?.next = ListNode(3)
        head.next?.next?.next?.next = ListNode(6)

        print("Input: \(head.val)")
        var output = Solution().addTwoNumbers(head, head)

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
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        return addTwoNumbers(l1, l2, 0)
    }

    private func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?, _ val: Int) -> ListNode? {
        if l1 == nil && l2 == nil && val == 0 { return nil }
        if l1 == nil && l2 == nil && val == 1 { return ListNode(1) }

        var currentNodesSum = val

        if let l1Node = l1 {
            currentNodesSum += l1Node.val
        }

        if let l2Node = l2 {
            currentNodesSum += l2Node.val
        }

        if currentNodesSum >= 10 {
            return ListNode((currentNodesSum-10), addTwoNumbers(l1?.next, l2?.next, 1))
        } else {
            return ListNode(currentNodesSum, addTwoNumbers(l1?.next, l2?.next, 0))
        }
    }
}

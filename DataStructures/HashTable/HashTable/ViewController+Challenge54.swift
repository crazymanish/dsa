//
//  ViewController+Challenge54.swift
//  HashTable
//
//  Created by Manish Rathi on 29/03/2022.
//

import Foundation
/*
 141. Linked List Cycle
 https://leetcode.com/problems/linked-list-cycle/
 Given head, the head of a linked list, determine if the linked list has a cycle in it.
 There is a cycle in a linked list if there is some node in the list that can be reached again by continuously following the next pointer. Internally, pos is used to denote the index of the node that tail's next pointer is connected to. Note that pos is not passed as a parameter.

 Return true if there is a cycle in the linked list. Otherwise, return false.

 Example 1:
 Input: head = [3,2,0,-4], pos = 1
 Output: true
 Explanation: There is a cycle in the linked list, where the tail connects to the 1st node (0-indexed).

 Example 2:
 Input: head = [1,2], pos = 0
 Output: true
 Explanation: There is a cycle in the linked list, where the tail connects to the 0th node.

 Example 3:
 Input: head = [1], pos = -1
 Output: false
 Explanation: There is no cycle in the linked list.
 */

extension ViewController {
    func solve54() {
        print("Setting up Challenge54 input!")

        let list1 = ListNode(2)
        list1.next = ListNode(3)
        list1.next?.next = ListNode(4)

        let output = Solution().hasCycle(list1)
        print("Output: \(output)")
    }
}

private class ListNode {
    var val: Int
    var next: ListNode?
    init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

private class Solution {
    func hasCycle(_ head: ListNode?) -> Bool {
        if head == nil { return false }

        var slowPointer = head
        var fastPointer = head?.next

        var hasCycle = false

        while true {
            if fastPointer == nil { break }

            if fastPointer === slowPointer {
                hasCycle = true
                break
            }

            slowPointer = slowPointer?.next
            fastPointer = fastPointer?.next?.next
        }

        return hasCycle
    }
}

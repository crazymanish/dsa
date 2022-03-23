//
//  ViewController+Problem12.swift
//  Recursion
//
//  Created by Manish Rathi on 23/03/2022.
//

import Foundation
/*
 143. Reorder List
 https://leetcode.com/problems/reorder-list/
 You are given the head of a singly linked-list. The list can be represented as:

 L0 → L1 → … → Ln - 1 → Ln
 Reorder the list to be on the following form:

 L0 → Ln → L1 → Ln - 1 → L2 → Ln - 2 → …
 You may not modify the values in the list's nodes. Only nodes themselves may be changed.

 Example 1:
 Input: head = [1,2,3,4]
 Output: [1,4,2,3]

 Example 2:
 Input: head = [1,2,3,4,5]
 Output: [1,5,2,4,3]
 */

extension ViewController {
    func solve12() {
        print("Setting up Problem12 input!")

        let head = ListNode(1)
        head.next = ListNode(2)
        head.next?.next = ListNode(3)
        head.next?.next?.next = ListNode(4)

        print("Input: \(head.val)")
        Solution().reorderList(head)

        var output: ListNode? = head
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
    func reorderList(_ head: ListNode?) {
        if head == nil { return }

        var node = head
        let stack = Stack()
        stack.push(node!)

        while let next = node?.next {
            stack.push(next)
            node = next
        }

        node = head
        while let next = node?.next, let endNode = stack.pop() {

            node?.next = endNode
            endNode.next = next

            node = next

            if node?.next === endNode {
                node?.next = nil
                break
            }
        }
    }
}

private class Stack {
    private var array: [ListNode] = []

    func push(_ element: ListNode) {
        array.append(element)
    }

    func pop() -> ListNode? {
        if array.isEmpty { return nil }

        return array.removeLast()
    }
}

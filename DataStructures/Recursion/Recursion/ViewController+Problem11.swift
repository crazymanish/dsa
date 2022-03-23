//
//  ViewController+Problem11.swift
//  Recursion
//
//  Created by Manish Rathi on 23/03/2022.
//

import Foundation
/*
 24. Swap Nodes in Pairs
 https://leetcode.com/problems/swap-nodes-in-pairs/
 Given a linked list, swap every two adjacent nodes and return its head. You must solve the problem without modifying the values in the list's nodes (i.e., only nodes themselves may be changed.)

 Example 1:
 Input: head = [1,2,3,4]
 Output: [2,1,4,3]

 Example 2:
 Input: head = []
 Output: []

 Example 3:
 Input: head = [1]
 Output: [1]
 */

extension ViewController {
    func solve11() {
        print("Setting up Problem11 input!")

        let head = ListNode(1)
        head.next = ListNode(2)
        head.next?.next = ListNode(3)
        head.next?.next?.next = ListNode(4)

        print("Input: \(head.val)")
        var output = Solution().swapPairs(head)

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
    func swapPairs(_ head: ListNode?) -> ListNode? {
        if head == nil { return nil }
        if head?.next == nil { return head }

        let temp = head?.next
        head?.next = swapPairs(head?.next?.next)

        temp?.next = head

        return temp
    }
}

//
//  ViewController+Challenge52.swift
//  HashTable
//
//  Created by Manish Rathi on 29/03/2022.
//

import Foundation
/*
 160. Intersection of Two Linked Lists
 https://leetcode.com/problems/intersection-of-two-linked-lists/
 Given the heads of two singly linked-lists headA and headB, return the node at which the two lists intersect. If the two linked lists have no intersection at all, return null.

 For example, the following two linked lists begin to intersect at node c1:
 The test cases are generated such that there are no cycles anywhere in the entire linked structure.
 Note that the linked lists must retain their original structure after the function returns.
 Custom Judge:
 The inputs to the judge are given as follows (your program is not given these inputs):
 intersectVal - The value of the node where the intersection occurs. This is 0 if there is no intersected node.
 listA - The first linked list.
 listB - The second linked list.
 skipA - The number of nodes to skip ahead in listA (starting from the head) to get to the intersected node.
 skipB - The number of nodes to skip ahead in listB (starting from the head) to get to the intersected node.
 The judge will then create the linked structure based on these inputs and pass the two heads, headA and headB to your program. If you correctly return the intersected node, then your solution will be accepted.

 Example 1:
 Input: intersectVal = 8, listA = [4,1,8,4,5], listB = [5,6,1,8,4,5], skipA = 2, skipB = 3
 Output: Intersected at '8'
 Explanation: The intersected node's value is 8 (note that this must not be 0 if the two lists intersect).
 From the head of A, it reads as [4,1,8,4,5]. From the head of B, it reads as [5,6,1,8,4,5]. There are 2 nodes before the intersected node in A; There are 3 nodes before the intersected node in B.

 Example 2:
 Input: intersectVal = 2, listA = [1,9,1,2,4], listB = [3,2,4], skipA = 3, skipB = 1
 Output: Intersected at '2'
 Explanation: The intersected node's value is 2 (note that this must not be 0 if the two lists intersect).
 From the head of A, it reads as [1,9,1,2,4]. From the head of B, it reads as [3,2,4]. There are 3 nodes before the intersected node in A; There are 1 node before the intersected node in B.

 Example 3:
 Input: intersectVal = 0, listA = [2,6,4], listB = [1,5], skipA = 3, skipB = 2
 Output: No intersection
 Explanation: From the head of A, it reads as [2,6,4]. From the head of B, it reads as [1,5]. Since the two lists do not intersect, intersectVal must be 0, while skipA and skipB can be arbitrary values.
 Explanation: The two lists do not intersect, so return null.
 */

extension ViewController {
    func solve52() {
        print("Setting up Challenge52 input!")

        let list1 = ListNode(2)
        list1.next = ListNode(3)
        list1.next?.next = ListNode(4)

        let output = Solution().getIntersectionNode(list1, list1.next)
        print("Output: \(output!.val)")
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
    func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
        if headA == nil || headB == nil { return nil }

        var head1 = headA
        var head2 = headB

        var head1count = 0
        var head2count = 0

        while head1 != nil {
            head1count += 1
            head1 = head1?.next
        }

        while head2 != nil {
            head2count += 1
            head2 = head2?.next
        }

        var diff = abs(head2count-head1count)
        head1 = headA
        head2 = headB

        if diff > 0 {
            if head1count > head2count {
                while diff != 0 {
                    diff -= 1
                    head1 = head1?.next
                }
            } else {
                while diff != 0 {
                    diff -= 1
                    head2 = head2?.next
                }
            }
        }

        var intersectionNode: ListNode? = nil

        while true {
            if head1 == nil || head2 == nil { break }

            if head1! === head2! {
                intersectionNode = head1
                break
            }

            head1 = head1?.next
            head2 = head2?.next
        }


        return intersectionNode
    }
}

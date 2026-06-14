/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init() { self.val = 0; self.next = nil; }
 *     public init(_ val: Int) { self.val = val; self.next = nil; }
 *     public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 * }
 */

class Solution {
    /**
     Problem Summary:
     Given a linked list with an even number of nodes, return the maximum twin sum.
     A twin pair is formed by the i-th node from the start and the i-th node from the end.

     Strategy:
     Use fast and slow pointers to find the middle of the list while reversing the first half.
     Then compare the reversed first half with the second half to find the maximum twin sum.
     Finally, restore the first half back to its original direction while traversing.

     Time Complexity:
     O(n), where n is the number of nodes in the linked list.

     Space Complexity:
     O(1), because the list is reversed in-place.
     */
    func pairSum(_ head: ListNode?) -> Int {
        var fastPointer = head
        var slowPointer = head
        var reversedFirstHalfHead: ListNode?

        // Reverse the first half while finding the middle.
        while fastPointer != nil {
            let nextSlowNode = slowPointer?.next
            let nextFastNode = fastPointer?.next?.next

            slowPointer?.next = reversedFirstHalfHead
            reversedFirstHalfHead = slowPointer

            slowPointer = nextSlowNode
            fastPointer = nextFastNode
        }

        var firstHalfNode = reversedFirstHalfHead
        var secondHalfNode = slowPointer
        var restoredPreviousNode = slowPointer
        var maximumTwinSum = 0

        // Compare both halves and restore the reversed first half.
        while firstHalfNode != nil {
            maximumTwinSum = max(
                maximumTwinSum,
                firstHalfNode!.val + secondHalfNode!.val
            )

            let nextFirstHalfNode = firstHalfNode?.next

            firstHalfNode?.next = restoredPreviousNode
            restoredPreviousNode = firstHalfNode

            firstHalfNode = nextFirstHalfNode
            secondHalfNode = secondHalfNode?.next
        }

        return maximumTwinSum
    }
}
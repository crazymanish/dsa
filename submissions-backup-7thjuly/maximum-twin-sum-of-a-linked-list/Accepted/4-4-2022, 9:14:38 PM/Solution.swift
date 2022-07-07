// https://leetcode.com/problems/maximum-twin-sum-of-a-linked-list

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
    func pairSum(_ head: ListNode?) -> Int {
        if head?.next == nil { return head!.val }

        var pointer1 = head
        var pointer2 = head

        // Run pointer2 with double speed to find the mid-node
        while pointer2?.next?.next != nil {
            pointer1 = pointer1?.next
            pointer2 = pointer2?.next?.next
        }

        // We are now middle of LinkedList, lets reset the pointer agains
        // but List maybe EVEN or ODD
        // if pointer2?.next == nil { pointer2 = pointer1 } // ODD
        if pointer2?.next?.next == nil { pointer2 = pointer1?.next } // EVEN

        // Reset pointer1 with head & reverse pointer2
        pointer1 = head
        pointer2 = reverseList(pointer2, nil)

        return pairSum(pointer1, pointer2)
    }

    private func reverseList(_ head: ListNode?, _ previous: ListNode?) -> ListNode? {
        if head == nil { return previous }

        let next = head?.next
        head?.next = previous

        return reverseList(next, head)
    }

    private func pairSum(_ head1: ListNode?, _ head2: ListNode?) -> Int {
        var pointer1 = head1
        var pointer2 = head2

        var maxSum = Int.min

        while pointer2 != nil {
            let currentPairSum = pointer1!.val + pointer2!.val
            maxSum = max(maxSum, currentPairSum)

            pointer1 = pointer1?.next
            pointer2 = pointer2?.next
        }

        return maxSum
    }
}
// https://leetcode.com/problems/reorder-list

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
    func reorderList(_ head: ListNode?) {
        if head == nil { return }

        var pointer1 = head
        var pointer2 = head

        // Run pointer2 with double speed to find the mid-node
        while pointer2?.next?.next != nil {
            pointer1 = pointer1?.next
            pointer2 = pointer2?.next?.next
        }

        // We are now middle of LinkedList, lets reset the pointer agains
        // but List maybe EVEN or ODD
        if pointer2?.next == nil { pointer2 = pointer1 } // ODD
        if pointer2?.next?.next == nil { pointer2 = pointer1?.next } // EVEN

        // reset pointer1 & reverse pointer2
        pointer1 = head
        pointer2 = reverseList(pointer2, nil)

        // Reorder nodes
        while pointer1?.next != nil && pointer2?.next != nil {
            let pointer1Next = pointer1!.next
            let pointer2Next = pointer2!.next

            pointer1!.next = pointer2
            pointer2!.next = pointer1Next

            pointer1 = pointer1Next
            pointer2 = pointer2Next
        }
    }

    private func reverseList(_ current: ListNode?, _ previous: ListNode?) -> ListNode? {
        if current == nil { return previous }

        let next = current?.next
        current?.next = previous

        return reverseList(next, current)
    }
}

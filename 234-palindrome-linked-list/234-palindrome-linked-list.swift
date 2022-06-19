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
    func isPalindrome(_ head: ListNode?) -> Bool {
        if head == nil { return false }

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

        // Reset pointer1 with head & reverse pointer2
        pointer1 = head
        pointer2 = reverseList(pointer2, nil)

        return isPalindrome(pointer1, pointer2)
    }

    private func reverseList(_ head: ListNode?, _ previous: ListNode?) -> ListNode? {
        if head == nil { return previous }

        let next = head?.next
        head?.next = previous

        return reverseList(next, head)
    }

    private func isPalindrome(_ head1: ListNode?, _ head2: ListNode?) -> Bool {
        var pointer1 = head1
        var pointer2 = head2

        var isPalindrome = true

        while pointer2 != nil {
            if pointer1!.val != pointer2!.val {
                isPalindrome = false
                break
            }

            pointer1 = pointer1?.next
            pointer2 = pointer2?.next
        }

        return isPalindrome
    }
}

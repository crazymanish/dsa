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

/**
 Problem Summary:
 Rotate a singly linked list to the right by `k` places.

 Strategy:
 1. Traverse the list to:
    - Count the total number of nodes.
    - Get a reference to the tail node.
 2. Connect the tail to the head to form a circular list.
 3. Compute the effective rotation using `k % length`.
 4. Find the new tail:
    - It will be at position `length - (k % length) - 1` from the head.
 5. Break the circular link to form the new list.

 Time Complexity:
 O(n) — Single pass to count nodes + another pass to locate new tail.

 Space Complexity:
 O(1) — No extra space used.
 */
class Solution {
    func rotateRight(_ head: ListNode?, _ k: Int) -> ListNode? {
        // Edge case: empty list or single node → no rotation needed
        guard let head = head, head.next != nil else { return head }
        
        var tail: ListNode? = head
        var length = 1
        
        // Step 1: Find the length and the tail node
        while tail?.next != nil {
            tail = tail?.next
            length += 1
        }
        
        // Step 2: Make the list circular
        tail?.next = head
        
        // Step 3: Compute effective rotations
        let effectiveRotations = k % length
        
        // Step 4: Find new tail position
        // Move (length - effectiveRotations) steps from current tail
        var stepsToNewTail = length - effectiveRotations
        var current: ListNode? = tail
        
        while stepsToNewTail > 0 {
            current = current?.next
            stepsToNewTail -= 1
        }
        
        // Step 5: Break the circle to form new list
        let newHead = current?.next
        current?.next = nil
        
        return newHead
    }
}
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

/*
 1. Advance an initial offset
 2. Save the pointer which is pointing to the node which has to be flipped with the other one
 3. Advance fast pointer until it reaches the end so the slow pointer is at the point we want.
 4. Switch this last pointer's value with the previously saved one
 
 Time complexity: O(N)
 Space complexity: O(1)
 */
class Solution {
    func swapNodes(_ head: ListNode?, _ k: Int) -> ListNode? {
        
        if head == nil || head?.next == nil { return head }
        
        var k = k
        
        var slow = head
        var fast = slow
        
        /// We're using 1-indexed arrays
        /// Advance the fast pointer until the K-th point here we'll have
        /// the starting point of the two pointers we'll have to switch later on
        while k > 1 {
            fast = fast?.next
            k -= 1
        }
        
        /// Save the starting point
        var swapStart = fast
        
        /// Advance the fast/slow pointers until the fast reaches the end
        /// so that the slow pointer is at length - k point
        while fast?.next != nil {
            fast = fast?.next
            slow = slow?.next
        }
        
        /// The slow pointer is now at the node we want to switch with
        /// the other value saved previously
        var swapEnd = slow
        
        /// Switch the node's value from the two saved nodes
        let temp = swapStart!.val
        swapStart!.val = swapEnd!.val
        swapEnd!.val = temp
        
        return head
    }
}
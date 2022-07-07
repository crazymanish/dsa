// https://leetcode.com/problems/rotate-list

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
    func rotateRight(_ head: ListNode?, _ k: Int) -> ListNode? {
        if head == nil { return nil }

        var pointer1 = head
        var pointer2 = head

        // Run pointer2 after pointer1 is already k times ahead
        var nodeCounter = 0
        while pointer1?.next != nil {
            pointer1 = pointer1?.next
            
            if nodeCounter >= k {
                pointer2 = pointer2?.next   
            }
            
            nodeCounter += 1
        }
        
        // List does not contain k element?
        if pointer2?.next == nil { return nil }
        
        // Let's finish rotation, at this moment
        // Pointer1 ==> Node(5)
        // Pointer2 ==> Node(3)

        // Pointer3 ==> will become Node(4)
        let pointer3 = pointer2?.next 

        // Let's make Node(3) --> next NIL
        pointer2?.next = nil
        
        // Let's join head as Node(5) ---> next  
        pointer1?.next = head
        
        // return Node(4)
        return pointer3
    }
}
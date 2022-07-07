// https://leetcode.com/problems/remove-nth-node-from-end-of-list

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
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        if head == nil || head?.next == nil { return nil } 
        
        let dummyNode = ListNode(-1, head)
        var slowPointer: ListNode? = dummyNode
        var fastPointer = head
        
        var index = 1
        while fastPointer != nil {
            if index > n {
                slowPointer = slowPointer?.next
            }
            
            fastPointer = fastPointer?.next
            index += 1
        }
        
        slowPointer?.next =  slowPointer?.next?.next
        
        return dummyNode.next
    }
}
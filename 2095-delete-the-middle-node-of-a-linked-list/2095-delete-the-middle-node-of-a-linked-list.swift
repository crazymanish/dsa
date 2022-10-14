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
    func deleteMiddle(_ head: ListNode?) -> ListNode? {
        if head == nil || head?.next == nil { return nil }
        
        let dummyNode = ListNode(-1, head)
        var slowPointer: ListNode? = dummyNode
        var fastPointer = head
        
        while fastPointer?.next != nil {
            slowPointer = slowPointer?.next
            fastPointer = fastPointer?.next?.next
        }
        
        slowPointer?.next = slowPointer?.next?.next
        
        return head
    }
}
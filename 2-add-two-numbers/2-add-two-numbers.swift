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
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        return addTwoNumbers(l1, l2, 0)
    }
    
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?, _ val: Int) -> ListNode? {
        if l1 == nil && l2 == nil && val == 0 { return nil }
        if l1 == nil && l2 == nil && val == 1 { return ListNode(1) }
        
        var currentNodesSum = val
        
        if let l1Node = l1 {
            currentNodesSum += l1Node.val
        }
        
        if let l2Node = l2 {
            currentNodesSum += l2Node.val
        }
        
        if currentNodesSum >= 10 {
            return ListNode((currentNodesSum-10), addTwoNumbers(l1?.next, l2?.next, 1))
        } else {
            return ListNode(currentNodesSum, addTwoNumbers(l1?.next, l2?.next, 0))
        }
    }
}
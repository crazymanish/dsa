// https://leetcode.com/problems/reverse-linked-list

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
    func reverseList(_ head: ListNode?) -> ListNode? {
        return reverseList(head, nil)
    }
    
    private func reverseList(_ current: ListNode?, _ previous: ListNode?) -> ListNode? {
        if current == nil { return previous }
        
        var next = current?.next
        current?.next = previous
        
        return reverseList(next, current)
    }
}
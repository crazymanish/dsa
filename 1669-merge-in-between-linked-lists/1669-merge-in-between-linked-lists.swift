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
    func mergeInBetween(_ list1: ListNode?, _ a: Int, _ b: Int, _ list2: ListNode?) -> ListNode? {
        guard list1 != nil else { return nil }
        
        var runner = list1
        var index = 0
        var start: ListNode?
        var end: ListNode?

        // find A and B
        while runner != nil {
            if index == a-1 { start = runner }
            
            if index == b+1 { end = runner; break }
            
            runner = runner?.next
            index += 1
        }

        // connect start
        start?.next = list2

        // connect end
        runner = list2
        while runner?.next != nil {
            runner = runner?.next
        } 
        runner?.next = end

        return list1
    }
}
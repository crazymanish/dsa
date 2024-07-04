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
    func mergeNodes(_ head: ListNode?, _ sum: Int = 0) -> ListNode? {
        guard let head else { return nil }

        if sum != 0 && head.val == 0 {
            return ListNode(sum, mergeNodes(head.next, 0))
        } else {
            return mergeNodes(head.next, sum + head.val)
        } 
    }
}
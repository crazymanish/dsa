// https://leetcode.com/problems/merge-two-sorted-lists

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
    func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        if list1 == nil && list2 == nil { return nil }
        if list1 == nil { return list2 }
        if list2 == nil { return list1 }
        
        guard let list1Node = list1, let list2Node = list2 else { return nil }
        
        if list1Node.val < list2Node.val {
            return ListNode(list1Node.val, mergeTwoLists(list1Node.next, list2Node))
        } else {
            return ListNode(list2Node.val, mergeTwoLists(list1Node, list2Node.next))
        }
    }
}
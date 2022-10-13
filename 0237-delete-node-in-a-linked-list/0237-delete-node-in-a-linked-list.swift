/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.next = nil
 *     }
 * }
 */

/*
How it works: 
ListNode is a class object, the original head already points to the node's address and any changes that happen to the delete node automatically are referenced by the original head.
*/

class Solution {
    func deleteNode(_ node: ListNode?) {
        guard let nextNode = node?.next else { return }
            
        node?.val = nextNode.val
        node?.next = nextNode.next
    }
}
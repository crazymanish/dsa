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
    func insertGreatestCommonDivisors(_ head: ListNode?) -> ListNode? {        
        func gcd(_ a: Int, _ b: Int) -> Int { b == 0 ? a : gcd(b, a % b) }
        
        var (node, next) = (head, head?.next)
        
        while next != nil {
            // Create the new node to insert.
            let gcdNode = ListNode(gcd(node!.val, next!.val))

            // Wire-up the nodes: node -> gcdNode -> next
            node!.next = gcdNode
            gcdNode.next = next

            // Go to the next node.
            (node, next) = (next, next?.next)
        }
        
        return head
    }
}
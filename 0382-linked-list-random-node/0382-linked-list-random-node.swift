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

    /** @param head The linked list's head.
        Note that the head is guaranteed to be not null, so it contains at least one node. */
    var head: ListNode?
    
    init(_ head: ListNode?) {
         self.head = head  
    }
    
    /** Returns a random node's value. */
    func getRandom() -> Int {
        var value = 0 
        var currentNode = head 
        var count = 0
        
        while currentNode != nil {
            count += 1
            
            if Int.random(in: 0..<count) == 0 {
                value = currentNode!.val
            }    
            
            currentNode = currentNode!.next
        }
        
        return value
    }
}
/**
 * Your Solution object will be instantiated and called as such:
 * let obj = Solution(head)
 * let ret_1: Int = obj.getRandom()
 */
// https://leetcode.com/problems/linked-list-cycle

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

class Solution {
    func hasCycle(_ head: ListNode?) -> Bool {
        if head == nil { return false }
        
        var slowPointer = head
        var fastPointer = head?.next
        
        var hasCycle = false
        
        while true {
            if fastPointer == nil { break }
            
            if fastPointer === slowPointer {
                hasCycle = true
                break
            }
            
            slowPointer = slowPointer?.next
            fastPointer = fastPointer?.next?.next
        }
        
        return hasCycle
    }
}
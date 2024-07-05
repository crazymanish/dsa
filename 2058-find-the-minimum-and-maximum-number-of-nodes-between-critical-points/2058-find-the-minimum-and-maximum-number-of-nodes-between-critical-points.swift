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
    func nodesBetweenCriticalPoints(_ head: ListNode?) -> [Int] {
        var foundCritical = false        
        var distanceToPrevCritical = 0
        var minDistance = Int.max, maxDistance = 0

        var prevVal = head!.val
        var node: ListNode! = head!.next
        
        while true {
            if node.next == nil { break }
            
            if (node.val < prevVal && node.val < node.next!.val) ||
               (node.val > prevVal && node.val > node.next!.val) {
                foundCritical = true
                   
                if distanceToPrevCritical != 0 {
                    minDistance = min(minDistance, distanceToPrevCritical)
                    maxDistance += distanceToPrevCritical                    
                    distanceToPrevCritical = 0
                }
            }
            
            prevVal = node.val
            node = node.next
            
            if foundCritical {
                distanceToPrevCritical += 1
            }
        }

        if maxDistance == 0 { return [-1, -1] }
        
        return [minDistance, maxDistance]
    }
}
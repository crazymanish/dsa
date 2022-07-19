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
    func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
        if headA == nil || headB == nil { return nil }
        
        var head1 = headA
        var head2 = headB
        
        var head1count = 0
        var head2count = 0
        
        while head1 != nil {
            head1count += 1
            head1 = head1?.next
        }
        
        while head2 != nil {
            head2count += 1
            head2 = head2?.next
        }
        
        var diff = abs(head2count-head1count)
        head1 = headA
        head2 = headB
        
        if diff > 0 {
            if head1count > head2count {
                while diff != 0 {
                    diff -= 1
                    head1 = head1?.next
                }
            } else {
                while diff != 0 {
                    diff -= 1
                    head2 = head2?.next
                }
            }   
        }
        
        var intersectionNode: ListNode? = nil
        
        while true {            
            if head1 == nil || head2 == nil { break }
            
            if head1! === head2! {
                intersectionNode = head1
                break
            }
            
            head1 = head1?.next
            head2 = head2?.next
        }
        
        
        return intersectionNode
    }
}
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
	func oddEvenList(_ head: ListNode?) -> ListNode? {
		let oddHead = head
		let evenHead = head?.next
		var oddNode = oddHead
		var evenNode = evenHead
		
        while true {
			var haveNext = false
			
            if let oddNext = oddNode?.next?.next {
				haveNext = true
				oddNode?.next = oddNext
				oddNode = oddNext
			}
            
			if let evenNext = evenNode?.next?.next {
				haveNext = true
				evenNode?.next = evenNext
				evenNode = evenNext
			}
			
            if haveNext == false { break }
		}
        
		oddNode?.next = evenHead
		evenNode?.next = nil
		
        return oddHead
	}
}
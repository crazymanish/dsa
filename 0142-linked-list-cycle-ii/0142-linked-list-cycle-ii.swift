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
    func detectCycle(_ head: ListNode?) -> ListNode? {
	    var slowPointer = head
	    var fastPointer = head

	    // iterate over the list
	    while fastPointer != nil {
		    slowPointer = slowPointer?.next
		    fastPointer = fastPointer!.next?.next

		    if slowPointer === fastPointer { break }
	    }

	    if fastPointer == nil { return nil }

	    slowPointer = head
	    while slowPointer !== fastPointer {
		    slowPointer = slowPointer?.next
		    fastPointer = fastPointer?.next
	    }

	    return slowPointer
    }
}
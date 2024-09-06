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
    func modifiedList(_ nums: [Int], _ head: ListNode?) -> ListNode? {
        let nums = Set(nums)
        var dummy = ListNode(0, head)
        var runner = dummy
        
		while true { 
            // greedy rewire `runner.next`
            while let next = runner.next, nums.contains(next.val) {
                runner.next = next.next
            }
            
            guard let next = runner.next else { return dummy.next }
            
            runner = next
        }
    }
}
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

/**
 * Definition for singly-linked list.
 * public class ListNode {
 * public var val: Int
 * public var next: ListNode?
 * public init() { self.val = 0; self.next = nil; }
 * public init(_ val: Int) { self.val = val; self.next = nil; }
 * public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 * }
 */
class Solution {

    // --- Complexity Analysis ---
    //
    // Time Complexity: O(N + M)
    //   - N is the number of elements in the `nums` array.
    //   - M is the number of nodes in the linked list (`head`).
    //
    // 1. Building the Set: Creating `valuesToRemove` from the `nums` array
    //    takes O(N) time on average.
    // 2. Traversing the List: The `while` loop iterates through the linked list.
    //    Each node is visited at most twice:
    //    - Once by the `nodeToInspect` pointer (if it's checked).
    //    - Once by the `prev` pointer (if it's a "good" node to advance to).
    //    The `Set.contains()` check is O(1) on average.
    //    Therefore, traversing the list takes O(M) time.
    //
    // Total Time = O(N) + O(M) = O(N + M)
    //
    // Space Complexity: O(N)
    //   - The primary extra space is used by the `valuesToRemove` set, which
    //     stores up to N unique elements. This requires O(N) space.
    //   - The `dummyHead` and `prev` pointers use constant O(1) space.

    /// Removes all nodes from a linked list whose values are present in an array `nums`.
    func modifiedList(_ nums: [Int], _ head: ListNode?) -> ListNode? {
        
        // Convert the `nums` array to a Set for efficient O(1) average lookup time.
        let valuesToRemove = Set(nums)
        
        // Use a dummy head node. This simplifies edge cases, such as
        // having to remove the *original* head node of the list.
        let dummyHead = ListNode(0, head)
        
        // `prev` will always point to the last known "good" node
        // (i.e., a node that is *not* in `valuesToRemove`).
        // We start `prev` at the dummy node.
        var prev = dummyHead
        
        // We will loop until we process the entire list.
        while true {
            
            // --- "Greedy Skip" Phase ---
            // Look ahead from `prev` and skip over any and all nodes
            // that need to be deleted.
            // `prev.next` is repeatedly re-wired until it points to
            // a node that *shouldn't* be deleted, or to `nil`.
            while let nodeToInspect = prev.next, valuesToRemove.contains(nodeToInspect.val) {
                // `nodeToInspect` needs to be deleted.
                // We bypass it by setting `prev.next` to point to whatever
                // came *after* `nodeToInspect`.
                prev.next = nodeToInspect.next
            }
            
            // --- "Advance" or "Exit" Phase ---
            // At this point, we know `prev.next` is either:
            // 1. `nil` (we have reached the end of the list).
            // 2. A "good" node (its value is not in `valuesToRemove`).
            
            // We use `guard let` to safely unwrap `prev.next`.
            // If it's `nil`, we have finished processing the list.
            guard let nextGoodNode = prev.next else {
                // We're done. Return the head of the modified list.
                return dummyHead.next
            }
            
            // If we're here, `nextGoodNode` is a node we are keeping.
            // We must now advance our `prev` pointer to this "good" node
            // so we can start inspecting the nodes *after* it.
            prev = nextGoodNode
        }
    }
}
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
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init() { self.val = 0; self.left = nil; self.right = nil; }
 *     public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
 *     public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
 *         self.val = val
 *         self.left = left
 *         self.right = right
 *     }
 * }
 */

class Solution {
    func isSubPath(_ head: ListNode?, _ root: TreeNode?) -> Bool {    
        guard let root else { return false }
        
        func isSubPathStartingAt(_ list: ListNode?, _ start: TreeNode?) -> Bool {
            guard let list else { return true }
            guard let start else { return false }
            
            return list.val == start.val && (                  // List and tree start with the same value and,
                isSubPathStartingAt(list.next, start.left) ||  // rest of the list continues on the left side, or,
                isSubPathStartingAt(list.next, start.right))   // rest of the list continues on the right side.
        }
        
        return isSubPathStartingAt(head, root)  // List starts exactly at root,
            || isSubPath(head, root.left)       // or list starts somewhere in the left tree,
            || isSubPath(head, root.right)      // or list starts somewhere in the right tree.
    }
}
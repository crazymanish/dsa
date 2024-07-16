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
    func getDirections(_ root: TreeNode?, _ startValue: Int, _ destValue: Int) -> String {
        func path(_ root: TreeNode?, _ value: Int) -> String? {
            guard let root else { return nil }
            
            if root.val == value { return "" }
            if let leftPath = path(root.left, value) { return "L" + leftPath }
            if let rightPath = path(root.right, value) { return "R" + rightPath }
            
            return nil
        }
        
        let startPath = path(root, startValue)!
        let destPath = path(root, destValue)!

        let commonPrefix = startPath.commonPrefix(with: destPath)
        let prefixLength = commonPrefix.count
    
        let up = String(Array(startPath)[prefixLength...].map { _ in "U" })
        let down = String(Array(destPath)[prefixLength...])

        return up + down
    }
}
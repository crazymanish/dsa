// https://leetcode.com/problems/find-duplicate-subtrees

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
    var hashMap: [String: Int] = [:]
    var output: [String: TreeNode] = [:]
    func findDuplicateSubtrees(_ root: TreeNode?) -> [TreeNode?] {
        traverseTreeAndSaveIntoHashMap(root)
        
        return Array(output.values)
    }
    
    private func traverseTreeAndSaveIntoHashMap(_ root: TreeNode?) -> [String] {
        guard let currentNode = root else { return ["nil"] }
        
        let leftTraverse = traverseTreeAndSaveIntoHashMap(currentNode.left)
        let rightTraverse = traverseTreeAndSaveIntoHashMap(currentNode.right)
        
        let currentTraverse = ["\(currentNode.val)"] + leftTraverse + rightTraverse
        
        let key = currentTraverse.joined(separator: ",")
        
        let hashMapValue = hashMap[key] ?? 0
        hashMap[key] = hashMapValue + 1
        
        if hashMapValue > 0 { output[key] = currentNode }
        
        return currentTraverse
    }
}
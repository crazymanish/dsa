// https://leetcode.com/problems/validate-binary-search-tree

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
    private var hashMap: [Int: Int] = [:]
    
    func isValidBST(_ root: TreeNode?) -> Bool {
        guard let currentNode = root else { return false }
        
        let leftMax = findMax(currentNode.left)
        let rightMax = findMax(currentNode.right)
        if leftMax > currentNode.val || rightMax < currentNode.val { return false }
        
        let isLeftValidBST = isValidBST(currentNode.left)
        let isRightValidBST = isValidBST(currentNode.right)
        
        return isLeftValidBST && isRightValidBST
    }
    
    private func findMax(_ root: TreeNode?) -> Int {
        guard let currentNode = root else { return Int.min }
        
        let currentNodeValue = currentNode.val
        
        if let cacheMax = hashMap[currentNodeValue] { return cacheMax }
        
        let leftMax = findMax(currentNode.left)
        let rightMax = findMax(currentNode.right)

        let childMax = max(leftMax, rightMax)
        let currentMax = max(currentNodeValue, childMax)
        hashMap[currentNodeValue] = currentMax
        
        return currentMax
    }
}

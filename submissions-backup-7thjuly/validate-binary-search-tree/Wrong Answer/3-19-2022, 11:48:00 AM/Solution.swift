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
    private var maxHashMap: [Int: Int] = [:]
    private var minHashMap: [Int: Int] = [:]
    
    func isValidBST(_ root: TreeNode?) -> Bool {
        guard let currentNode = root else { return false }
        
        if currentNode.isLeafNode { return true }
        
        let isLeftValidBST = isValidBST(currentNode.left)
        let isRightValidBST = isValidBST(currentNode.right)
        
        let leftMax = findMax(currentNode.left)
        let rightMin = findMin(currentNode.right)
        let isCurrentNodeValidBST = leftMax < currentNode.val && rightMin > currentNode.val
        
        return isLeftValidBST && isCurrentNodeValidBST && isRightValidBST
    }
    
    private func findMax(_ root: TreeNode?) -> Int {
        guard let currentNode = root else { return Int.min }
        
        let currentNodeValue = currentNode.val
        
        if let cacheMax = maxHashMap[currentNodeValue] { return cacheMax }
        
        let leftMax = findMax(currentNode.left)
        let rightMax = findMax(currentNode.right)

        let childMax = max(leftMax, rightMax)
        let currentMax = max(currentNodeValue, childMax)
        maxHashMap[currentNodeValue] = currentMax
        
        return currentMax
    }
    
    private func findMin(_ root: TreeNode?) -> Int {
        guard let currentNode = root else { return Int.max }
        
        let currentNodeValue = currentNode.val
        
        if let cacheMin = minHashMap[currentNodeValue] { return cacheMin }
        
        let leftMin = findMin(currentNode.left)
        let rightMin = findMin(currentNode.right)

        let childMin = min(leftMin, rightMin)
        let currentMin = min(currentNodeValue, childMin)
        minHashMap[currentNodeValue] = currentMin
        
        return currentMin
    }
}

private extension TreeNode {
    var isLeafNode: Bool { left == nil && right == nil }
}

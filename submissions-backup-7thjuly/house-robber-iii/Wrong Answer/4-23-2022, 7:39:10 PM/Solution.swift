// https://leetcode.com/problems/house-robber-iii

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
    func rob(_ root: TreeNode?) -> Int {
        func findMaxRobMoney(_ root: TreeNode?) -> Int {
            guard let currentNode = root else { return 0 }
            
            let leftChildLeftSideRobMoney = findMaxRobMoney(currentNode.left?.left)
            let leftChildRightSideRobMoney = findMaxRobMoney(currentNode.left?.right)
            let leftChildMaxRobMoney = max(leftChildLeftSideRobMoney, leftChildRightSideRobMoney)
            
            let rightChildLeftSideRobMoney = findMaxRobMoney(currentNode.right?.left)
            let rightChildRightSideRobMoney = findMaxRobMoney(currentNode.right?.right)
            let rightChildMaxRobMoney = max(rightChildLeftSideRobMoney, rightChildRightSideRobMoney)
            
            return currentNode.val + leftChildMaxRobMoney + rightChildMaxRobMoney
        }
        
        // Consider root
        let maxRobMoneyWithRoot = findMaxRobMoney(root)
        
        // Dont consider root, just childs
        let maxRobMoneyWithLeftChild = findMaxRobMoney(root?.left)
        let maxRobMoneyWithRightChild = findMaxRobMoney(root?.right)
        let maxRobMoneyWithChilds = maxRobMoneyWithLeftChild + maxRobMoneyWithRightChild
        
        return max(maxRobMoneyWithRoot, maxRobMoneyWithChilds)
    }
}
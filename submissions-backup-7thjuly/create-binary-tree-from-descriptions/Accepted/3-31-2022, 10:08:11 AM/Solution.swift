// https://leetcode.com/problems/create-binary-tree-from-descriptions

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
    func createBinaryTree(_ descriptions: [[Int]]) -> TreeNode? {
        if descriptions.isEmpty { return nil }
        
        var parentHashMap: [Int : TreeNode] = [:]
        var childHashMap: [Int : TreeNode] = [:]
        
        for description in descriptions {
            let parentNodeValue = description[0]
            let childNodeValue = description[1]
            
            let parentNode = parentHashMap[parentNodeValue] ?? childHashMap[parentNodeValue] ?? TreeNode(parentNodeValue)
            let childNode =  childHashMap[childNodeValue] ?? parentHashMap[childNodeValue] ?? TreeNode(childNodeValue)
            
            if description[2] == 1 {
                parentNode.left = childNode
            } else {
                parentNode.right = childNode
            }
            
            parentHashMap[parentNodeValue] = parentNode
            childHashMap[childNodeValue] = childNode
        }
        
        var rootNode: TreeNode? = nil
        
        for (key, value) in parentHashMap {
            if childHashMap[key] == nil {
                rootNode = value
                break
            }
        }
        
        return rootNode
    }
}
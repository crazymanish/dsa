// https://leetcode.com/problems/n-ary-tree-postorder-traversal

/**
 * Definition for a Node.
 * public class Node {
 *     public var val: Int
 *     public var children: [Node]
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.children = []
 *     }
 * }
 */

class Solution {
    func postorder(_ root: Node?) -> [Int] {
    	guard let currentNode = root else { return [] }
        
        var childrenPostorder: [Int] = []
        for childNode in currentNode.children {
            let childNodePostorder = postorder(childNode)
            
            childrenPostorder += childNodePostorder
        }
        
        return childrenPostorder + [currentNode.val]
    }
}
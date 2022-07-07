// https://leetcode.com/problems/n-ary-tree-preorder-traversal

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
    func preorder(_ root: Node?) -> [Int] {
    	guard let currentNode = root else { return [] }
        
        var childrenPreorder: [Int] = []
        for childNode in currentNode.children {
            let childNodePreorder = preorder(childNode)
            
            childrenPreorder += childNodePreorder
        }
        
        return [currentNode.val] + childrenPreorder
    }
}
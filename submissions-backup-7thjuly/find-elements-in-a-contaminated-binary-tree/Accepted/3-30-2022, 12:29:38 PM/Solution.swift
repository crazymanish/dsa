// https://leetcode.com/problems/find-elements-in-a-contaminated-binary-tree

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

class FindElements {
    var hashMap: [Int : Bool] = [:]
    
    init(_ root: TreeNode?) {
        root?.val = 0
        parseTreeAndSaveValueIntoHashMap(root)
    }
    
    func find(_ target: Int) -> Bool {
        return hashMap[target] ?? false
    }
    
    private func parseTreeAndSaveValueIntoHashMap(_ root: TreeNode?) {
        guard let currentNode = root else { return }
        
        let currentNodeValue = currentNode.val
        hashMap[currentNodeValue] = true
        
        let leftValue = currentNodeValue * 2 + 1
        let rightValue = currentNodeValue * 2 + 2
        
        currentNode.left?.val = leftValue
        currentNode.right?.val = rightValue
        
        parseTreeAndSaveValueIntoHashMap(currentNode.left)
        parseTreeAndSaveValueIntoHashMap(currentNode.right)
    }
}

/**
 * Your FindElements object will be instantiated and called as such:
 * let obj = FindElements(root)
 * let ret_1: Bool = obj.find(target)
 */
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
    func generateTrees(_ n: Int) -> [TreeNode?] {
        func dfs(left: Int, right: Int) -> [TreeNode] {
            if left > right { return [] }
            if left == right { return [TreeNode(left)] }
    
            var binaryTrees = [TreeNode]()
            for root in left...right {
                let leftNodes = dfs(left: left, right: root-1)
                let rightNodes = dfs(left: root+1, right: right)
                
                for leftIndex in 0..<max(leftNodes.count, 1) {
                    for rightIndex in 0..<max(rightNodes.count, 1) {
                        let rootNode = TreeNode(
                            root, 
                            leftNodes[safe: leftIndex], 
                            rightNodes[safe: rightIndex])
                        
                        binaryTrees.append(rootNode)
                    }
                }
            }
            
            return binaryTrees
        }
        
        return dfs(left: 1, right: n)
    }
}

extension Array {
    subscript (safe index: Int) -> Element? {
        guard index < count else { return nil }
        
        return self[index]
    }
}
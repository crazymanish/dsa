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
    private var deepestLevel = Int.min
    private var deepestLevelNodeValuesMap: [Int: [Int]] = [:]

    func deepestLeavesSum(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        
        findDeepestLeaves(root, 0)
        
        let deepestLevelNodeValues = deepestLevelNodeValuesMap[deepestLevel]!

        var outputSum = 0
        
        for deepestLevelNodeValue in deepestLevelNodeValues {
            outputSum += deepestLevelNodeValue
        }
        
        return outputSum
    }
    
    private func findDeepestLeaves(_ root: TreeNode?, _ currentLevel: Int) {
        guard let currentNode = root else { return }
        
        let newLevel = currentLevel + 1
        
        if currentNode.left == nil && currentNode.right == nil {
            deepestLevel = max(deepestLevel, newLevel)
            
            if let deepestLevelNodeValues = deepestLevelNodeValuesMap[newLevel] {
                deepestLevelNodeValuesMap[newLevel] = deepestLevelNodeValues + [currentNode.val]
            } else {
                deepestLevelNodeValuesMap[newLevel] = [currentNode.val]
            }
        }
        
        findDeepestLeaves(currentNode.left, newLevel)
        findDeepestLeaves(currentNode.right, newLevel)
    }
}
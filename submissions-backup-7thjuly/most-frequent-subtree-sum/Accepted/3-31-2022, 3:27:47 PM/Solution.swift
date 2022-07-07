// https://leetcode.com/problems/most-frequent-subtree-sum

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
    var hashMap: [Int : Int] = [:]
    
    func findFrequentTreeSum(_ root: TreeNode?) -> [Int] {
        if root == nil { return [] }
        
        findTreeSum(root)
        
        let highestFrequency = Array(hashMap.values).sorted().last!

        var output: [Int] = []
        for (key, value) in hashMap {
            if value == highestFrequency { output.append(key) }
        }
        
        return output
    }
    
    private func findTreeSum(_ root: TreeNode?) -> Int {
        guard let currentNode = root else { return 0 }
        
        let leftSum = findTreeSum(currentNode.left)
        let rightSum = findTreeSum(currentNode.right)
        
        let currentNodeSum = currentNode.val + leftSum + rightSum
        
        let hashMapValue = hashMap[currentNodeSum] ?? 0
        hashMap[currentNodeSum] = hashMapValue + 1
        
        return currentNodeSum
    }
}
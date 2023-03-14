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
    func sumNumbers(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        
        func findAllPathNumbers(_ root: TreeNode?, _ currentPath: String) -> [Int] {
            guard let currentNode = root else { return [] }

            let newPath = currentPath + "\(currentNode.val)"

            if currentNode.isLeafNode { return [Int(newPath)!] }

            let leftPathNumbers = findAllPathNumbers(currentNode.left, newPath)
            let rightPathNumbers = findAllPathNumbers(currentNode.right, newPath)

            return leftPathNumbers + rightPathNumbers
        }

        var outputSum = 0
        let pathNumbers = findAllPathNumbers(root, "")
        for pathNumber in pathNumbers { outputSum += pathNumber }
        return outputSum
    }
}

private extension TreeNode {
    var isLeafNode: Bool { left == nil && right == nil }
}
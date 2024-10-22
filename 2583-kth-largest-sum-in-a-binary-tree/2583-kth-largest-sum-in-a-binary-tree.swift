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
    func kthLargestLevelSum(_ root: TreeNode?, _ k: Int) -> Int {
        guard let root else { return -1 }

        var queue = [root]
        var levelSums = [Int]()

        while !queue.isEmpty {
            levelSums.append(queue.reduce(0) { $0 + $1.val })
            queue = queue.flatMap { [$0.left, $0.right] }.compactMap { $0 }
        }

        levelSums.sort(by: >)

        return levelSums.count >= k ? levelSums[k-1] : -1
    }
}
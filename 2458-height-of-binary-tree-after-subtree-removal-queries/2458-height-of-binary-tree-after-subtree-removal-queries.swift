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
    func treeQueries(_ root: TreeNode?, _ queries: [Int]) -> [Int] {
        var valToMaxHeight = [Int: Int]()
        var heightDict = [Int: Int]()

        // Step 1: Calculate the height of each node once and store it in `heightDict`
        func calculateHeight(_ root: TreeNode?) -> Int {
            guard let root = root else {
                return 0
            }
            if let height = heightDict[root.val] {
                return height
            }
            let height = 1 + max(calculateHeight(root.left), calculateHeight(root.right))
            heightDict[root.val] = height
            return height
        }

        _ = calculateHeight(root)

        // Step 2: Use DFS with precomputed heights to fill `valToMaxHeight`
        func dfs(_ root: TreeNode?, _ depth: Int, _ maxHeight: Int) {
            guard let root = root else {
                return
            }
            valToMaxHeight[root.val] = maxHeight
            dfs(root.left, depth + 1, max(maxHeight, depth + (heightDict[root.right?.val ?? 0] ?? 0)))
            dfs(root.right, depth + 1, max(maxHeight, depth + (heightDict[root.left?.val ?? 0] ?? 0)))
        }

        dfs(root, 0, 0)

        // Step 3: Map queries to the results stored in `valToMaxHeight`
        return queries.map { valToMaxHeight[$0] ?? 0 }
    }
}
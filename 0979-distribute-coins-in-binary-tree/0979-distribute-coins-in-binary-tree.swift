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
    func distributeCoins(_ root: TreeNode?) -> Int {
        distributeCoins(root).moves
    }
    
    private func distributeCoins(_ root: TreeNode?) -> (balance: Int, moves: Int) {
        guard let root else { return (.zero, .zero) }
        
        let (lBalance, lMoves) = distributeCoins(root.left)
        let (rBalance, rMoves) = distributeCoins(root.right)
        
        return (
            lBalance + rBalance + root.val - 1, 
            lMoves + rMoves + abs(rBalance) + abs(lBalance)
        )
    }
}
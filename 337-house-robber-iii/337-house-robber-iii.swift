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
    func rob(_ root: TreeNode?) -> Int {
        typealias IncludeExcludeRootReturnValue = (Int, Int)
        func findMaxRobMoney(_ root: TreeNode?) -> IncludeExcludeRootReturnValue {
            guard let currentNode = root else { return (0, 0) }
            
            let leftRobMoney = findMaxRobMoney(currentNode.left)
            let rightRobMoney = findMaxRobMoney(currentNode.right)
            
            // Include Root, include root with exclude left, right
            let robMoneyIncludeRoot = currentNode.val + leftRobMoney.1 + rightRobMoney.1
            
            // Exclude Root, then consider max of left-child & max of right-child
            let robMoneyExcludeRoot = max(leftRobMoney.0, leftRobMoney.1) + max(rightRobMoney.0, rightRobMoney.1)
            
            return (robMoneyIncludeRoot, robMoneyExcludeRoot)
        }
        
        /*
        We can divide this problem to two sub problems:
        Subproblem 1: Starting Robbing house with root (Include root)
        Subproblem 2: Starting Robbing house with childs (Exclude root)
        And find the bigger one of these two sub problems.
        */
        let (robMoneyIncludeRoot, robMoneyExcludeRoot) = findMaxRobMoney(root)
        return max(robMoneyIncludeRoot, robMoneyExcludeRoot)
    }
}
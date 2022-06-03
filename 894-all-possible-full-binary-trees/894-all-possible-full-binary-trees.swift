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
    private var hashMap: [Int: [TreeNode]] = [:]
    
    func allPossibleFBT(_ n: Int) -> [TreeNode?] {
        if n == 0 { return [] }
        if n == 1 { return [TreeNode(0)] }
        if let cacheFBT = hashMap[n] { return cacheFBT }
        
        var result: [TreeNode] = []
        
        for possibleLeftNode in 1..<n {
            let possibleRightNode = n - possibleLeftNode - 1
            
            let leftPossibleFBTs = allPossibleFBT(possibleLeftNode)
            let rightPossibleFBTs = allPossibleFBT(possibleRightNode)
            
            for leftPossibleFBT in leftPossibleFBTs {
                for rightPossibleFBT in rightPossibleFBTs {
                    result.append(TreeNode(0, leftPossibleFBT, rightPossibleFBT))
                } 
            }
            
            hashMap[n] = result
        }
        
        return result
    }
}
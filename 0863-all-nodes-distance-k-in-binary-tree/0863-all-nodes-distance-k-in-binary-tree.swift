/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.left = nil
 *         self.right = nil
 *     }
 * }
 */
class Solution {
    func distanceK(_ root: TreeNode?, _ target: TreeNode?, _ k: Int) -> [Int] {
        if target == nil { return [] }
        
        var hashMap = [TreeNode: TreeNode]()

        func dfs(_ node: TreeNode?, _ parent: TreeNode?) {
            guard let node = node else {return}
            
            if parent != nil { hashMap[node] = parent }
            
            dfs(node.left, node)
            dfs(node.right, node)
        }
        dfs(root, nil)
        
        var seen = Set<TreeNode>()
        seen.insert(target!)
        var queue = [target!]
        var distance = 0
        while queue.isEmpty == false {
            let temp = queue
            queue.removeAll()
            
            if distance == k {
                return temp.map {$0.val}
            }
            
            for node in temp {
                if node.left != nil && seen.contains(node.left!) == false {
                    seen.insert(node.left!)
                    queue.append(node.left!)
                } 
                if node.right != nil && seen.contains(node.right!) == false {
                    seen.insert(node.right!)
                    queue.append(node.right!)
                }
                if let parent = hashMap[node], seen.contains(parent) == false {
                    seen.insert(parent)
                    queue.append(parent)
                }
            }
            distance += 1
        }
        
        return []
    }
}

extension TreeNode: Hashable {
    public static func == (l: TreeNode, r: TreeNode) -> Bool {
        l === r
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self).hashValue)
    }
}
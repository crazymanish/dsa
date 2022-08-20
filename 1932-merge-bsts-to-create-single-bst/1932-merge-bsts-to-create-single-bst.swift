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
    func canMerge(_ trees: [TreeNode?]) -> TreeNode? {
        var rootNodeHashMap: [Int : TreeNode] = [:]
        var parentNodeHashMap: [TreeNode : TreeNode] = [:]
        var visitedTreeNodes = Set<Int>()
        
        let allTrees: [TreeNode] = trees.compactMap { $0 }
        
        for tree in allTrees {
            rootNodeHashMap[tree.val] = tree 
        }
        
        for tree in allTrees {
            visitedTreeNodes.insert(tree.val)
            
            if let rightTree = tree.right {
                visitedTreeNodes.insert(rightTree.val)
                
                let rightRootNode = rootNodeHashMap[rightTree.val]
                
                if let rightRootNode = rightRootNode {
                    let parentNode = parentNodeHashMap[tree]
                    
                    //check if the node trying to connect is not the current root's parent
                    //this check works becuase all bst in this question has at most 3 nodes.
                    if parentNode != rightRootNode {
                        tree.right = rightRootNode
                        rootNodeHashMap[rightTree.val] = nil
                        parentNodeHashMap[rightTree] = tree
                    }
                }
            }
            
            if let leftTree = tree.left {
                visitedTreeNodes.insert(leftTree.val)
                
                let leftRootNode = rootNodeHashMap[leftTree.val]
                
                if let leftRootNode = leftRootNode {
                    let parentNode = parentNodeHashMap[tree]
                    
                    //check if the node trying to connect is not the current root's parent
                    //this check works becuase all bst in this question has at most 3 nodes.
                    if parentNode != leftRootNode {
                        tree.left = leftRootNode
                        rootNodeHashMap[leftTree.val] = nil
                        parentNodeHashMap[leftTree] = tree
                    }
                }
            }
        }
        
        func isBST(_ treeNode: TreeNode?, _ minElement: Int = Int.min, _ maxElement: Int = Int.max) -> Bool {
            guard let treeNode = treeNode else { return true }
            
            if(treeNode.val <= minElement || treeNode.val >= maxElement) { return false }
            
            return isBST(treeNode.left, minElement, treeNode.val) && isBST(treeNode.right, treeNode.val, maxElement)
        }
        
        func findSize(_ treeNode: TreeNode?) -> Int {
            guard let treeNode = treeNode else { return 0 }
            
            return 1 + findSize(treeNode.left) + findSize(treeNode.right)
        }
        
        let rootNode = Array(rootNodeHashMap.values).first
        
        if isBST(rootNode) == false { return nil }
        
       if findSize(rootNode) != visitedTreeNodes.count { return nil }
        
        return rootNode
    }
}

extension TreeNode: Hashable {
    public static func == (lhs: TreeNode, rhs: TreeNode) -> Bool {
        lhs.val == rhs.val && lhs.left?.val == rhs.left?.val && lhs.right?.val == rhs.right?.val
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(val)
        hasher.combine(left?.val)
        hasher.combine(right?.val)
    }
}

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
 
/**
 * Problem Summary:
 * Build a binary tree from descriptions where each description contains:
 * - parent value
 * - child value
 * - whether the child is a left child or right child
 *
 * Strategy:
 * Use one dictionary to map each value to its TreeNode so every value has exactly one node object.
 * Use a set to track all values that appear as children.
 * After connecting all nodes, the root is the only parent value that never appears as a child.
 *
 * Time Complexity: O(n)
 * - We process each description once.
 *
 * Space Complexity: O(n)
 * - We store nodes and child values for all unique values.
 */
class Solution {
    func createBinaryTree(_ descriptions: [[Int]]) -> TreeNode? {
        var nodesByValue: [Int: TreeNode] = [:]
        var childValues = Set<Int>()

        for description in descriptions {
            let parentValue = description[0]
            let childValue = description[1]
            let isLeftChild = description[2] == 1

            // Reuse existing nodes if already created, otherwise create them.
            let parentNode = nodesByValue[parentValue] ?? TreeNode(parentValue)
            let childNode = nodesByValue[childValue] ?? TreeNode(childValue)

            // Store nodes back to ensure future references reuse the same objects.
            nodesByValue[parentValue] = parentNode
            nodesByValue[childValue] = childNode

            // Connect the child to the correct side of the parent.
            if isLeftChild {
                parentNode.left = childNode
            } else {
                parentNode.right = childNode
            }

            // Any node that appears as a child cannot be the root.
            childValues.insert(childValue)
        }

        // The root is the only node value that never appears as a child.
        for description in descriptions {
            let parentValue = description[0]

            if !childValues.contains(parentValue) {
                return nodesByValue[parentValue]
            }
        }

        return nil
    }
}
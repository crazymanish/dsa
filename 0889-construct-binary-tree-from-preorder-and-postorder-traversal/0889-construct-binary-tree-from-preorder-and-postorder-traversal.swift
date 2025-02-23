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
    func constructFromPrePost(_ preorder: [Int], _ postorder: [Int]) -> TreeNode? {
        // Nested function to create the tree recursively
        func createTree(preStart: Int, preEnd: Int, postStart: Int, postEnd: Int) -> TreeNode? {
            if preStart > preEnd { return nil } // Base case: empty subtree
            if preStart == preEnd { return TreeNode(preorder[preStart]) } // Base case: single node

            let root = TreeNode(preorder[preStart]) // Create the root node
            let nextVal = preorder[preStart + 1] // Value of the next node in preorder

            // Find the index of nextVal in postorder to determine subtree boundaries
            var leftSubtreeEndIndex = postStart
            while leftSubtreeEndIndex < postEnd {
                if postorder[leftSubtreeEndIndex] == nextVal { break }
                leftSubtreeEndIndex += 1
            }

            // Calculate the size of the left subtree
            let leftSubtreeSize = leftSubtreeEndIndex - postStart + 1

            // Recursively construct the left and right subtrees
            root.left = createTree(preStart: preStart + 1, preEnd: preStart + leftSubtreeSize, postStart: postStart, postEnd: leftSubtreeEndIndex)
            root.right = createTree(preStart: preStart + leftSubtreeSize + 1, preEnd: preEnd, postStart: leftSubtreeEndIndex + 1, postEnd: postEnd - 1)

            return root
        }

        // Call the nested function to start the tree construction
        return createTree(preStart: 0, preEnd: preorder.count - 1, postStart: 0, postEnd: postorder.count - 1)
    }
}
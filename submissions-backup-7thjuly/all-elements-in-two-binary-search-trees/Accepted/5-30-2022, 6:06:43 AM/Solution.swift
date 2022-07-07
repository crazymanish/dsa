// https://leetcode.com/problems/all-elements-in-two-binary-search-trees

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
    func getAllElements(_ root1: TreeNode?, _ root2: TreeNode?) -> [Int] {
        let root1Elements = inorderTraversal(root1)
        let root2Elements = inorderTraversal(root2)

        return mergeElementsInAscendingOrder(root1Elements, root2Elements)
    }

    private func inorderTraversal(_ root: TreeNode?) -> [Int] {
        guard let currentNode = root else { return [] }

        let leftInorder = inorderTraversal(currentNode.left)
        let rightInorder = inorderTraversal(currentNode.right)

        return leftInorder + [currentNode.val] + rightInorder
    }

    private func mergeElementsInAscendingOrder(_ array1: [Int], _ array2: [Int]) -> [Int] {
        var inputArray1 = array1
        var inputArray2 = array2
        var outputArray: [Int] = []

        while inputArray1.isEmpty == false || inputArray2.isEmpty == false {
            let minElement: Int

            if inputArray1.isEmpty {
                minElement = inputArray2.removeFirst()
            } else if inputArray2.isEmpty {
                minElement = inputArray1.removeFirst()
            } else {
                let array1FirstElement = inputArray1.first ?? Int.max
                let array2FirstElement = inputArray2.first ?? Int.max

                if array1FirstElement < array2FirstElement {
                    minElement = inputArray1.removeFirst()
                } else {
                    minElement = inputArray2.removeFirst()
                }
            }

            outputArray.append(minElement)
        }

        return outputArray
    }
}
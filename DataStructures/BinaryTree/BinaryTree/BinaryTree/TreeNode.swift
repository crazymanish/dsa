//
//  TreeNode.swift
//  BinaryTree
//
//  Created by Manish Rathi on 08/03/2022.
//

import Foundation

class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?

    init() {
        self.val = 0
        self.left = nil
        self.right = nil
    }

    init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }

    init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

extension TreeNode {
    var inorderTraversal: [Int] {
        return inorderTraversal(self)
    }

    var postorderTraversal: [Int] {
        return postorderTraversal(self)
    }

    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        if root == nil { return [] }

        let leftInorderTraversal = inorderTraversal(root?.left)
        let rightInorderTraversal = inorderTraversal(root?.right)

        return leftInorderTraversal + [root!.val] + rightInorderTraversal
    }

    func postorderTraversal(_ root: TreeNode?) -> [Int] {
        guard let rootNode = root else { return [] }

        let leftPostorderTraversal = postorderTraversal(rootNode.left)
        let rightPostorderTraversal = postorderTraversal(rootNode.right)

        return leftPostorderTraversal + rightPostorderTraversal + [rootNode.val]
    }
}

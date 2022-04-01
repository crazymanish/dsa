//
//  ViewController+Challenge70.swift
//  HashTable
//
//  Created by Manish Rathi on 01/04/2022.
//

import Foundation
/*
 1261. Find Elements in a Contaminated Binary Tree
 https://leetcode.com/problems/find-elements-in-a-contaminated-binary-tree/
 Given a binary tree with the following rules:
 root.val == 0
 If treeNode.val == x and treeNode.left != null, then treeNode.left.val == 2 * x + 1
 If treeNode.val == x and treeNode.right != null, then treeNode.right.val == 2 * x + 2
 Now the binary tree is contaminated, which means all treeNode.val have been changed to -1.

 Implement the FindElements class:
 FindElements(TreeNode* root) Initializes the object with a contaminated binary tree and recovers it.
 bool find(int target) Returns true if the target value exists in the recovered binary tree.


 Example 1:
 Input
 ["FindElements","find","find"]
 [[[-1,null,-1]],[1],[2]]
 Output
 [null,false,true]
 Explanation
 FindElements findElements = new FindElements([-1,null,-1]);
 findElements.find(1); // return False
 findElements.find(2); // return True

 Example 2:
 Input
 ["FindElements","find","find","find"]
 [[[-1,-1,-1,-1,-1]],[1],[3],[5]]
 Output
 [null,true,true,false]
 Explanation
 FindElements findElements = new FindElements([-1,-1,-1,-1,-1]);
 findElements.find(1); // return True
 findElements.find(3); // return True
 findElements.find(5); // return False

 Example 3:
 Input
 ["FindElements","find","find","find","find"]
 [[[-1,null,-1,-1,null,-1]],[2],[3],[4],[5]]
 Output
 [null,true,false,false,true]
 Explanation
 FindElements findElements = new FindElements([-1,null,-1,-1,null,-1]);
 findElements.find(2); // return True
 findElements.find(3); // return False
 findElements.find(4); // return False
 findElements.find(5); // return True
 */

extension ViewController {
    func solve70() {
        print("Setting up Challenge70 input!")

        let root = TreeNode(-1)
        root.right = TreeNode(-1)

        let obj = FindElements(root)
        var output = obj.find(1)
        print("Output: \(output)")
        output = obj.find(2)
        print("Output: \(output)")
    }
}

private class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    init() { self.val = 0; self.left = nil; self.right = nil; }
    init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

private class FindElements {
    var hashMap: [Int : Bool] = [:]

    init(_ root: TreeNode?) {
        root?.val = 0
        parseTreeAndSaveValueIntoHashMap(root)
    }

    func find(_ target: Int) -> Bool {
        return hashMap[target] ?? false
    }

    private func parseTreeAndSaveValueIntoHashMap(_ root: TreeNode?) {
        guard let currentNode = root else { return }

        let currentNodeValue = currentNode.val
        hashMap[currentNodeValue] = true

        let leftValue = currentNodeValue * 2 + 1
        let rightValue = currentNodeValue * 2 + 2

        currentNode.left?.val = leftValue
        currentNode.right?.val = rightValue

        parseTreeAndSaveValueIntoHashMap(currentNode.left)
        parseTreeAndSaveValueIntoHashMap(currentNode.right)
    }
}

//
//  ViewController+Problem2.swift
//  Day31
//
//  Created by Manish Rathi on 13/01/2022.
//

import Foundation
import dsa_reusable

/*
 https://www.geeksforgeeks.org/sum-nodes-binary-tree/
 Sum of all nodes in a binary tree

 Give an algorithm for finding the sum of all elements in a binary tree.

 1
 /\
2  3
/\   /\
4  5  6 7
 In the above binary tree sum = 28.
 */

extension ViewController {
    func sumOfBinaryTree() {
        let sum = sumOfBinaryTree(node: binaryTree.root)

        print("Binary tree sum: \(sum)")
    }

    private func sumOfBinaryTree(node: BinaryTree<Int>.Node<Int>?) -> Int {
        if node == nil { return 0 }

        return node!.data + sumOfBinaryTree(node: node!.left) + sumOfBinaryTree(node: node!.right)
    }

    /*
            1
            /\
           2  3
          /\   /\
         4  5  6 7
    */
    private var binaryTree: BinaryTree<Int> {
        var tree = BinaryTree<Int>()

        //1 will become root node of the tree
        tree.insert(data: 1)

        //2 will become left child and 3 will become right child of root node 1
        tree.insert(data: 2)
        tree.insert(data: 3)

        //4 will become left child and 5 will become right child of node 2
        tree.insert(data: 4)
        tree.insert(data: 5)

        //6 will become left child and 7 will become right child of node 3
        tree.insert(data: 6)
        tree.insert(data: 7)

        return tree
    }
}

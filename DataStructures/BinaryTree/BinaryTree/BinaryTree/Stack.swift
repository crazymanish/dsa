//
//  Stack.swift
//  BinaryTree
//
//  Created by Manish Rathi on 18/03/2022.
//

import Foundation

class Stack<T> {
    private var array: [T] = []

    var isEmpty: Bool { return array.isEmpty }

    var count: Int { return array.count }

    var top: T? { array.last }

    func push(_ value: T) {
        array.append(value)
    }

    func pop() -> T? {
        if isEmpty { return nil }

        return array.removeLast()
    }
}

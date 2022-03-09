//
//  Queue.swift
//  BinaryTree
//
//  Created by Manish Rathi on 09/03/2022.
//

import Foundation

class Queue<T> {
    private var array: [T] = []

    var isEmpty: Bool { return array.isEmpty }

    func enQueue(_ value: T) {
        array.append(value)
    }

    func deQueue() -> T? {
        if isEmpty { return nil }

        return array.removeFirst()
    }
}

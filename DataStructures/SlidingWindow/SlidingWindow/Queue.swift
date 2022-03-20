//
//  Queue.swift
//  SlidingWindow
//
//  Created by Manish Rathi on 20/03/2022.
//

import Foundation

class Queue<T> {
    var array: [T] = []

    var isEmpty: Bool { array.isEmpty }

    var count: Int { array.count }

    var front: T? { array.first }

    func enQueue(_ element: T) {
        array.append(element)
    }

    @discardableResult
    func deQueue() -> T? {
        if isEmpty { return nil }

        return array.removeFirst()
    }
}

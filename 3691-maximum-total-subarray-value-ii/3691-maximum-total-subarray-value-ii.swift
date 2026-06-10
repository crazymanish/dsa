/**
 * Problem Summary:
 * Given an integer array `nums`, select `k` subarrays and maximize the total
 * contribution, where each subarray contributes:
 *
 *      maximum value in subarray - minimum value in subarray
 *
 * Strategy:
 * - Build a segment tree that supports range maximum and range minimum queries.
 * - Start every left index with its widest valid range `[left...n - 1]`.
 * - Use a max-heap to repeatedly pick the current best subarray value.
 * - After choosing `[left...right]`, push the smaller range `[left...right - 1]`.
 *
 * Time Complexity:
 * - Build segment tree: O(n)
 * - Initial heap setup: O(n log n)
 * - Processing k candidates: O(k log² n)
 *
 * Space Complexity:
 * - O(n) for the segment tree
 * - O(n) for the heap
 */
class Solution {
    func maxTotalValue(_ nums: [Int], _ k: Int) -> Int {
        let count = nums.count
        let segmentTree = SegmentTree(nums)
        var maxHeap = Heap<SubarrayCandidate>()

        // Each left index starts with the largest possible right boundary.
        for leftIndex in 0..<count {
            maxHeap.push(SubarrayCandidate(value: segmentTree.rangeDifference(from: leftIndex, to: count - 1), left: leftIndex, right: count - 1))
        }

        var totalValue = 0
        var remainingSelections = k

        while remainingSelections > 0 {
            guard let bestCandidate = maxHeap.pop() else { break }

            totalValue += bestCandidate.value
            remainingSelections -= 1

            // Shrink the range from the right and continue exploring this left boundary.
            if bestCandidate.right > bestCandidate.left {
                let newRightIndex = bestCandidate.right - 1
                maxHeap.push(SubarrayCandidate(value: segmentTree.rangeDifference(from: bestCandidate.left, to: newRightIndex), left: bestCandidate.left, right: newRightIndex))
            }
        }

        return totalValue
    }
}

private final class SegmentTree {
    private let count: Int
    private var maxValues: [Int]
    private var minValues: [Int]

    init(_ nums: [Int]) {
        count = nums.count
        maxValues = Array(repeating: 0, count: 4 * count)
        minValues = Array(repeating: 0, count: 4 * count)
        build(node: 1, left: 0, right: count - 1, nums: nums)
    }

    func rangeDifference(from queryLeft: Int, to queryRight: Int) -> Int {
        rangeMax(from: queryLeft, to: queryRight) - rangeMin(from: queryLeft, to: queryRight)
    }

    private func rangeMax(from queryLeft: Int, to queryRight: Int) -> Int {
        queryMax(node: 1, left: 0, right: count - 1, queryLeft: queryLeft, queryRight: queryRight)
    }

    private func rangeMin(from queryLeft: Int, to queryRight: Int) -> Int {
        queryMin(node: 1, left: 0, right: count - 1, queryLeft: queryLeft, queryRight: queryRight)
    }

    private func build(node: Int, left: Int, right: Int, nums: [Int]) {
        if left == right {
            maxValues[node] = nums[left]
            minValues[node] = nums[left]
            return
        }

        let mid = left + (right - left) / 2

        build(node: node * 2, left: left, right: mid, nums: nums)
        build(node: node * 2 + 1, left: mid + 1, right: right, nums: nums)

        maxValues[node] = max(maxValues[node * 2], maxValues[node * 2 + 1])
        minValues[node] = min(minValues[node * 2], minValues[node * 2 + 1])
    }

    private func queryMax(node: Int, left: Int, right: Int, queryLeft: Int, queryRight: Int) -> Int {
        if queryLeft <= left && right <= queryRight { return maxValues[node] }

        let mid = left + (right - left) / 2
        var bestValue = Int.min

        if queryLeft <= mid {
            bestValue = max(bestValue, queryMax(node: node * 2, left: left, right: mid, queryLeft: queryLeft, queryRight: queryRight))
        }

        if queryRight > mid {
            bestValue = max(bestValue, queryMax(node: node * 2 + 1, left: mid + 1, right: right, queryLeft: queryLeft, queryRight: queryRight))
        }

        return bestValue
    }

    private func queryMin(node: Int, left: Int, right: Int, queryLeft: Int, queryRight: Int) -> Int {
        if queryLeft <= left && right <= queryRight { return minValues[node] }

        let mid = left + (right - left) / 2
        var bestValue = Int.max

        if queryLeft <= mid {
            bestValue = min(bestValue, queryMin(node: node * 2, left: left, right: mid, queryLeft: queryLeft, queryRight: queryRight))
        }

        if queryRight > mid {
            bestValue = min(bestValue, queryMin(node: node * 2 + 1, left: mid + 1, right: right, queryLeft: queryLeft, queryRight: queryRight))
        }

        return bestValue
    }
}

private struct SubarrayCandidate: Comparable {
    let value: Int
    let left: Int
    let right: Int

    // Reversed comparison makes the generic min-heap act like a max-heap.
    static func < (lhs: SubarrayCandidate, rhs: SubarrayCandidate) -> Bool {
        lhs.value > rhs.value
    }
}

private struct Heap<Element: Comparable> {
    private var elements: [Element] = []

    mutating func push(_ value: Element) {
        elements.append(value)
        siftUp(from: elements.count - 1)
    }

    mutating func pop() -> Element? {
        guard !elements.isEmpty else { return nil }

        if elements.count == 1 {
            return elements.removeLast()
        }

        let topValue = elements[0]
        elements[0] = elements.removeLast()
        siftDown(from: 0)

        return topValue
    }

    private mutating func siftUp(from index: Int) {
        var childIndex = index

        while childIndex > 0 {
            let parentIndex = (childIndex - 1) / 2
            guard elements[childIndex] < elements[parentIndex] else { break }

            elements.swapAt(childIndex, parentIndex)
            childIndex = parentIndex
        }
    }

    private mutating func siftDown(from index: Int) {
        var parentIndex = index

        while true {
            let leftChildIndex = parentIndex * 2 + 1
            let rightChildIndex = parentIndex * 2 + 2
            var bestIndex = parentIndex

            if leftChildIndex < elements.count, elements[leftChildIndex] < elements[bestIndex] {
                bestIndex = leftChildIndex
            }

            if rightChildIndex < elements.count, elements[rightChildIndex] < elements[bestIndex] {
                bestIndex = rightChildIndex
            }

            guard bestIndex != parentIndex else { break }

            elements.swapAt(parentIndex, bestIndex)
            parentIndex = bestIndex
        }
    }
}
class Solution {
    /**
     Problem Summary:
     Given an array, start at index `0` and reach the last index using the minimum number of jumps.
     From any index, you can jump to:
     - `index + 1`
     - `index - 1`
     - Any other index with the same value as `arr[index]`

     Strategy:
     Use Breadth-First Search because each jump has equal cost.
     Store all indices for each value in a dictionary so same-value jumps can be explored quickly.
     After using all same-value jumps for a number, remove that number from the dictionary to avoid repeated processing.

     Time Complexity:
     O(n), because each index is visited once, and each value group is processed once.

     Space Complexity:
     O(n), for the value-to-indices dictionary, visited array, and BFS queue.
     */
    func minJumps(_ arr: [Int]) -> Int {
        let lastIndex = arr.count - 1

        // Already at the destination.
        if lastIndex == 0 { return 0 }

        // Map each value to all indices where it appears.
        var valueToIndices: [Int: [Int]] = [:]

        for (index, value) in arr.enumerated() {
            valueToIndices[value, default: []].append(index)
        }

        // BFS queue stores indices to visit.
        // `steps` is tracked level-by-level instead of storing it with every queue element.
        var queue = [0]
        var head = 0
        var steps = 0

        // Array is faster and simpler than Set<Int> when indices are bounded by arr.count.
        var visited = Array(repeating: false, count: arr.count)
        visited[0] = true

        while head < queue.count {
            let currentLevelCount = queue.count - head

            // Process one BFS level, where all nodes are reachable in `steps` jumps.
            for _ in 0..<currentLevelCount {
                let currentIndex = queue[head]
                head += 1

                if currentIndex == lastIndex {
                    return steps
                }

                let currentValue = arr[currentIndex]

                // Collect all valid jump candidates:
                // adjacent indices plus indices with the same value.
                var nextIndices = valueToIndices[currentValue, default: []]

                if currentIndex + 1 <= lastIndex {
                    nextIndices.append(currentIndex + 1)
                }

                if currentIndex - 1 >= 0 {
                    nextIndices.append(currentIndex - 1)
                }

                // Remove this value group after processing it once.
                // This prevents repeatedly adding the same-value indices and keeps BFS O(n).
                valueToIndices[currentValue] = nil

                for nextIndex in nextIndices {
                    // Skip indices that were already reached by a shorter or equal path.
                    if visited[nextIndex] {
                        continue
                    }

                    visited[nextIndex] = true
                    queue.append(nextIndex)
                }
            }

            steps += 1
        }

        return -1
    }
}
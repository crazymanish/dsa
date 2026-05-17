class Solution {
    /**
     Problem Summary:
     Given an array where each value represents a jump distance, determine whether we can
     reach any index with value `0` starting from `start`.

     Strategy:
     Use BFS from the starting index. From each index, we can jump either:
     - forward: `index + arr[index]`
     - backward: `index - arr[index]`

     Track visited indices to avoid cycles and repeated work.

     Time Complexity:
     O(n), where n is the number of elements in `arr`.

     Space Complexity:
     O(n), for the visited array and BFS queue.
     */
    func canReach(_ arr: [Int], _ start: Int) -> Bool {
        var visited = Array(repeating: false, count: arr.count)

        // Use a queue for BFS. `queueHead` avoids the O(n) cost of removeFirst().
        var queue = [start]
        var queueHead = 0

        while queueHead < queue.count {
            let currentIndex = queue[queueHead]
            queueHead += 1

            // Skip indices that were already processed to avoid cycles.
            if visited[currentIndex] {
                continue
            }

            // We found a reachable index whose value is 0.
            if arr[currentIndex] == 0 {
                return true
            }

            visited[currentIndex] = true

            let jumpDistance = arr[currentIndex]
            let forwardIndex = currentIndex + jumpDistance
            let backwardIndex = currentIndex - jumpDistance

            // Add the forward jump if it stays inside the array.
            if forwardIndex < arr.count {
                queue.append(forwardIndex)
            }

            // Add the backward jump if it stays inside the array.
            if backwardIndex >= 0 {
                queue.append(backwardIndex)
            }
        }

        return false
    }
}
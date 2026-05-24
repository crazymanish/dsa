class Solution {
    /**
     Problem Summary:
     Given an array `arr` and a maximum jump distance `d`, return the maximum number
     of indices that can be visited. From index `i`, you may jump left or right up to
     `d` positions, but only to indices with smaller values. You cannot jump past an
     index with a value greater than or equal to `arr[i]`.

     Strategy:
     Use DFS with memoization.
     - `maxJumpsFromIndex[i]` stores the best result starting from index `i`.
     - From each index, explore valid jumps to the right and left.
     - Stop exploring in a direction as soon as an invalid blocking index is found.

     Time Complexity:
     O(n * d), where `n` is the number of elements in `arr`.

     Space Complexity:
     O(n), for the memoization array and recursion stack.
     */
    func maxJumps(_ arr: [Int], _ d: Int) -> Int {
        let count = arr.count
        var maxJumpsFromIndex = Array(repeating: -1, count: count)

        func dfs(_ currentIndex: Int) -> Int {
            // Return the cached result if this index was already solved.
            if maxJumpsFromIndex[currentIndex] != -1 {
                return maxJumpsFromIndex[currentIndex]
            }

            // At minimum, we can visit the current index itself.
            var bestReachableCount = 1

            // Try jumping to the right, up to distance `d`.
            for distance in 1...d {
                let nextIndex = currentIndex + distance

                // Stop if out of bounds or blocked by a greater/equal value.
                if nextIndex >= count || arr[nextIndex] >= arr[currentIndex] {
                    break
                }

                bestReachableCount = max(
                    bestReachableCount,
                    1 + dfs(nextIndex)
                )
            }

            // Try jumping to the left, up to distance `d`.
            for distance in 1...d {
                let nextIndex = currentIndex - distance

                // Stop if out of bounds or blocked by a greater/equal value.
                if nextIndex < 0 || arr[nextIndex] >= arr[currentIndex] {
                    break
                }

                bestReachableCount = max(
                    bestReachableCount,
                    1 + dfs(nextIndex)
                )
            }

            // Cache the best result starting from this index.
            maxJumpsFromIndex[currentIndex] = bestReachableCount
            return bestReachableCount
        }

        var answer = 1

        // Compute the best possible starting point.
        for index in 0..<count {
            answer = max(answer, dfs(index))
        }

        return answer
    }
}
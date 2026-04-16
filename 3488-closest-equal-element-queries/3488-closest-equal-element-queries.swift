class Solution {
    /**
     Problem Summary:
     Given an array `nums`, for each query index `i`, find the minimum circular distance
     to another index `j` such that `nums[i] == nums[j]`.
     If no such index exists, return -1 for that query.

     Strategy:
     1. Build a map from value → sorted list of indices where it appears.
     2. For each query:
        - If the value appears only once → return -1.
        - Otherwise, binary search to find the closest occurrence index.
     3. Compute the minimum circular distance using neighbors in the index list.

     Time Complexity:
     - Preprocessing: O(n)
     - Each query: O(log k), where k = frequency of the number
     - Total: O(n + q log k)

     Space Complexity:
     - O(n) for the index map
     */

    func solveQueries(_ nums: [Int], _ queries: [Int]) -> [Int] {
        // Map each value to all its occurrence indices
        let valueToIndices = nums.enumerated().reduce(into: [Int: [Int]]()) {
            $0[$1.element, default: []].append($1.offset)
        }

        var results: [Int] = []

        for queryIndex in queries {
            let value = nums[queryIndex]

            // If value appears only once → no valid pair
            guard let indices = valueToIndices[value], indices.count > 1 else {
                results.append(-1)
                continue
            }

            // Find closest occurrence using binary search
            let distance = findClosestDistance(
                indices: indices,
                targetIndex: queryIndex,
                totalCount: nums.count
            )

            results.append(distance)
        }

        return results
    }

    /**
     Binary search to locate the position of targetIndex
     in the sorted indices array.
     */
    private func findClosestDistance(indices: [Int], targetIndex: Int, totalCount: Int) -> Int {
        var left = 0
        var right = indices.count - 1

        // Standard binary search to find exact index
        while left < right {
            let mid = (left + right) / 2

            if indices[mid] == targetIndex {
                left = mid
                break
            } else if indices[mid] > targetIndex {
                right = mid - 1
            } else {
                left = mid + 1
            }
        }

        return computeMinimumDistance(
            indices: indices,
            position: left,
            totalCount: totalCount
        )
    }

    /**
     Computes minimum circular distance using neighbors
     in the indices array.
     */
    private func computeMinimumDistance(indices: [Int], position: Int, totalCount: Int) -> Int {

        var minimumDistance = Int.max
        let currentIndex = indices[position]

        // Check left neighbor
        if position > 0 {
            let leftNeighbor = indices[position - 1]

            // Direct distance
            minimumDistance = min(minimumDistance, currentIndex - leftNeighbor)

            // Circular wrap distance
            minimumDistance = min(
                minimumDistance,
                totalCount - currentIndex + indices[0]
            )
        }

        // Check right neighbor
        if position < indices.count - 1 {
            let rightNeighbor = indices[position + 1]

            // Direct distance
            minimumDistance = min(minimumDistance, rightNeighbor - currentIndex)

            // Circular wrap distance
            minimumDistance = min(
                minimumDistance,
                currentIndex + (totalCount - indices.last!)
            )
        }

        return minimumDistance
    }
}
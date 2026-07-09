class Solution {
    /**
     Problem Summary:
     Determine whether two queried indices belong to the same connected component.
     Adjacent indices are connected when the difference between their values is at most `maxDiff`.

     Strategy:
     Split `nums` into contiguous groups where every adjacent pair satisfies the allowed difference.
     Each query is true only if both indices fall inside the same group.

     Time Complexity: O(n + q log n), where q is the number of queries.
     Space Complexity: O(n), for storing the grouped chunks.
     */
    func pathExistenceQueries(_ n: Int, _ nums: [Int], _ maxDiff: Int, _ queries: [[Int]]) -> [Bool] {
        let connectedGroups = nums.chunked { previousValue, currentValue in
            currentValue - previousValue <= maxDiff
        }

        return queries.map { query in
            let firstNode = query[0]
            let secondNode = query[1]

            // Find the group containing each queried node index.
            let firstGroupIndex = connectedGroups.partitioningIndex { group in
                group.endIndex > firstNode
            }

            let secondGroupIndex = connectedGroups.partitioningIndex { group in
                group.endIndex > secondNode
            }

            // Nodes are connected only if they belong to the same group.
            return firstGroupIndex == secondGroupIndex
        }
    }
}
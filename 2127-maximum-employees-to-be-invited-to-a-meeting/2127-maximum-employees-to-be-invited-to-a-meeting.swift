class Solution {
    func maximumInvitations(_ favorite: [Int]) -> Int {
        // Each node can only be visited once in the entire run. (BitArray = space-optimized [Bool])
        var visited = [Bool](repeating: false, count: favorite.count)
        // Reverse map: list of who favorited each employee, as [Int:[Int]]
        var favoritedBy = Array(repeating: [Int](), count: favorite.count)
        for (i, f) in favorite.enumerated() {
            favoritedBy[f].append(i)
        }

        // GAME PLAN
        // There are two forms competing to win: clusters of doubletons and individual cycles.
        // We calculate the max size of both forms and return the maximum.

        // Form 1: Total Doubleton Cluster Count
        // Per description, there are no singletons (self-favorites), but there
        // are doubletons: two employees that are each other's favorites.
        var doubletons = [(Int, Int)]()
        for (a, b) in favorite.enumerated() {
            if a < b && favorite[b] == a {
                doubletons.append((a, b))
            }
        }

        // Each person in a doubleton (excluding the other) is a potential root node of
        // a DAG of forking chains of favorites. In each chain, the leaf node
        // favorites its parent node, etc., up to the root.
        // Goal: Recursively find the longest distance from root (doubleton member) to leaf.
        func longestFavoriteChainCount(_ i: Int, _ friend: Int) -> Int {
            guard !visited[i] else { return 0 }
            visited[i] = true
            var maxChainCount = 0
            for otherFriend in favoritedBy[i] where otherFriend != friend {
                maxChainCount = max(maxChainCount, longestFavoriteChainCount(otherFriend, friend))
            }
            return 1 /*this node*/ + maxChainCount
        }

        // We find the longest favorite chain for each member of the doubleton
        // and add these together (includes the doubleton). This unit is one "cluster".
        // We can seat all clusters at the table, so sum all doubleton cluster counts.
        var totalDoubletonClusterCount = 0
        for (employee, friend) in doubletons {
            let clusterCount = longestFavoriteChainCount(employee, friend) + longestFavoriteChainCount(friend, employee)
            totalDoubletonClusterCount += clusterCount
        }

        // Form 2: Longest Cycle Count
        // After processing doubletons, the `visited` array eliminates 2-cycles
        // from consideration. We only have 3+ cycles left. With multiple
        // 3+ cycles, mathematically only one cycle could be seated (and no one else).
        // Goal: Determine the longest 3+ cycle count.
        var cycleCounts = [Int: Int]()
        func getCycleCount(_ i: Int) -> Int {
            let friend = favorite[i]
            guard !visited[i], !visited[friend] else { return 0 }
            defer { visited[i] = true } // <-- happens at end of recursion
            let cycleCount = cycleCounts.count + 1
            if let earlierCycleCount = cycleCounts[friend] {
                // found a cycle, return its count
                cycleCounts = [:]
                return cycleCount - earlierCycleCount + 1
            }
            cycleCounts[i] = cycleCount
            return getCycleCount(friend)
        }

        let longestCycleCount = favorite.indices.map(getCycleCount).max() ?? 0

        // Return maximum of Form 1 and Form 2 counts
        return max(totalDoubletonClusterCount, longestCycleCount)
    }
}
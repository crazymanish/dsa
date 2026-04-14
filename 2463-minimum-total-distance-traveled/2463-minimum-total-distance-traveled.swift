class Solution {
    /**
     Problem Summary:
     Given the positions of robots and factories, where each factory can repair a limited
     number of robots, return the minimum total distance required to repair all robots.

     Strategy:
     1. Sort robot positions.
     2. Sort factories by position.
     3. Expand each factory by its repair limit, so each expanded entry represents one
        available repair slot at that factory position.
     4. Use top-down dynamic programming:
        - Either assign the current robot to the current factory slot
        - Or skip the current factory slot
     5. Memoize results for each `(robotIndex, factoryIndex)` state.

     Time Complexity:
     O(r * f), where:
     - r = number of robots
     - f = total expanded factory slots

     Space Complexity:
     O(r * f) for memoization, plus recursion stack depth O(r + f)
     */
    func minimumTotalDistance(_ robot: [Int], _ factory: [[Int]]) -> Int {
        let sortedRobots = robot.sorted()

        // Expand factories so each repair capacity becomes one usable slot.
        let factorySlots = factory
            .sorted { $0[0] < $1[0] }
            .flatMap { factoryInfo in
                Array(repeating: factoryInfo[0], count: factoryInfo[1])
            }

        let impossibleCost = 1_000_000_000_000
        var memo = Array(
            repeating: Array(repeating: -1, count: factorySlots.count),
            count: sortedRobots.count
        )

        return dfs(robotIndex: 0, factoryIndex: 0)

        func dfs(robotIndex: Int, factoryIndex: Int) -> Int {
            // All robots have been assigned successfully.
            if robotIndex == sortedRobots.count {
                return 0
            }

            // No factory slots left, but robots still remain.
            if factoryIndex == factorySlots.count {
                return impossibleCost
            }

            // Return cached result if this state was already computed.
            if memo[robotIndex][factoryIndex] != -1 {
                return memo[robotIndex][factoryIndex]
            }

            // Option 1: Assign the current robot to the current factory slot.
            let assignCurrentRobot =
                abs(factorySlots[factoryIndex] - sortedRobots[robotIndex]) +
                dfs(robotIndex: robotIndex + 1, factoryIndex: factoryIndex + 1)

            // Option 2: Skip this factory slot and try the next one.
            let skipCurrentFactorySlot = dfs(
                robotIndex: robotIndex,
                factoryIndex: factoryIndex + 1
            )

            // Store the best result for this state.
            memo[robotIndex][factoryIndex] = min(assignCurrentRobot, skipCurrentFactorySlot)
            return memo[robotIndex][factoryIndex]
        }
    }
}
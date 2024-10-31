class Solution {
    func minimumTotalDistance(_ robot: [Int], _ factory: [[Int]]) -> Int {
        let robots = robot.sorted()

        // Flatten the factories. If a factory has some "limit",
        // replace the factory with "limit" factories, each one
        // being able to repair a single robot.
        let factories = factory
            .sorted { $0[0] < $1[0] }
            .flatMap { Array(repeating: $0[0], count: $0[1]) }

        var dp = Array(repeating: Array(repeating: -1, count:factories.count), count: robots.count)

        return minimumTotalDistance(0, 0)

        func minimumTotalDistance(_ robotStartIndex: Int, _ factoryStartIndex: Int) -> Int {
            // Done, all robots have been repaired.
            if robotStartIndex == robots.count { return 0 }

            // No factories left. The current robot cannot be repaired.
            if factoryStartIndex == factories.count { return 1_000_000_000_000 }

            if dp[robotStartIndex][factoryStartIndex] >= 0 {
                return dp[robotStartIndex][factoryStartIndex]
            }

            // Assign the current robot to the current factory.
            let assign = abs(factories[factoryStartIndex] - robots[robotStartIndex]) + 
              minimumTotalDistance(robotStartIndex + 1, factoryStartIndex + 1)

            // Skip the current factory.
            let skip = minimumTotalDistance(robotStartIndex, factoryStartIndex + 1)

            dp[robotStartIndex][factoryStartIndex] = min(assign, skip)

            return dp[robotStartIndex][factoryStartIndex]
        }
    }
}
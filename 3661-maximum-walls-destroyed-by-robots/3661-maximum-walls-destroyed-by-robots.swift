class Solution {
    
    /**
     Problem Summary:
     Given robots positioned on a line, each with a shooting distance, and walls placed on the same line:
     - Each robot can shoot either left or right.
     - A robot destroys all walls within its shooting range in the chosen direction.
     - Overlapping destruction between consecutive robots must be handled carefully to avoid double counting.
     - Walls located exactly at robot positions are always destroyed.
     
     Goal: Maximize the number of destroyed walls.
     
     Strategy:
     1. Pair robot positions with distances and sort by position.
     2. Separate walls into:
        - Guaranteed destroyed (same position as robots)
        - Remaining walls (sorted for binary search)
     3. Use binary search to count walls in any interval efficiently.
     4. Dynamic Programming:
        - dp[i][0]: max walls destroyed up to robot i if robot i shoots LEFT
        - dp[i][1]: max walls destroyed up to robot i if robot i shoots RIGHT
     5. Carefully handle overlap between consecutive robots using inclusion-exclusion.
     6. Add final contribution of the last robot shooting right.
     
     Time Complexity:
     O(n log n + m log m)
     - Sorting robots and walls + binary searches per robot
     
     Space Complexity:
     O(n + m)
     - DP table + filtered walls
     */
    
    struct Robot {
        let position: Int
        let shootingDistance: Int
    }

    func maxWalls(_ robotPositions: [Int], _ distances: [Int], _ walls: [Int]) -> Int {
        let robotCount = robotPositions.count
        
        // Step 1: Combine robot data and sort by position
        var robots = [Robot]()
        for index in 0..<robotCount {
            robots.append(Robot(position: robotPositions[index],
                                shootingDistance: distances[index]))
        }
        robots.sort { $0.position < $1.position }
        
        // Step 2: Separate guaranteed walls (same position as robots)
        let robotPositionSet = Set(robotPositions)
        var guaranteedDestroyedWalls = 0
        var remainingWalls = [Int]()
        
        for wall in walls {
            if robotPositionSet.contains(wall) {
                guaranteedDestroyedWalls += 1
            } else {
                remainingWalls.append(wall)
            }
        }
        
        // Sort remaining walls for binary search
        remainingWalls.sort()
        
        // Step 3: Binary search helper to count walls in [left, right]
        func countWalls(inRange left: Int, _ right: Int) -> Int {
            if left > right { return 0 }
            
            let startIndex = remainingWalls.partitioningIndex { $0 >= left }
            let endIndex = remainingWalls.partitioningIndex { $0 > right }
            
            return endIndex - startIndex
        }
        
        // Step 4: DP initialization
        var dp = Array(repeating: [0, 0], count: robotCount)
        
        // First robot
        let firstRobot = robots[0]
        dp[0][0] = countWalls(inRange: firstRobot.position - firstRobot.shootingDistance,
                             firstRobot.position - 1)
        dp[0][1] = 0  // Right contribution handled later
        
        // Step 5: DP transitions
        for i in 1..<robotCount {
            let previousRobot = robots[i - 1]
            let currentRobot = robots[i]
            
            // Range A: previous robot shooting RIGHT (bounded by current robot)
            let rightShotLeft = previousRobot.position + 1
            let rightShotRight = min(previousRobot.position + previousRobot.shootingDistance,
                                     currentRobot.position - 1)
            
            // Range B: current robot shooting LEFT (bounded by previous robot)
            let leftShotLeft = max(currentRobot.position - currentRobot.shootingDistance,
                                   previousRobot.position + 1)
            let leftShotRight = currentRobot.position - 1
            
            let wallsFromPrevRight = countWalls(inRange: rightShotLeft, rightShotRight)
            let wallsFromCurrLeft = countWalls(inRange: leftShotLeft, leftShotRight)
            
            // Overlapping region (avoid double counting)
            let overlapLeft = max(rightShotLeft, leftShotLeft)
            let overlapRight = min(rightShotRight, leftShotRight)
            let overlapWalls = countWalls(inRange: overlapLeft, overlapRight)
            
            // Union of both ranges
            let unionWalls = wallsFromPrevRight + wallsFromCurrLeft - overlapWalls
            
            // Transition:
            // Current robot shoots LEFT
            dp[i][0] = max(
                dp[i - 1][0] + wallsFromCurrLeft,   // previous shot LEFT
                dp[i - 1][1] + unionWalls          // previous shot RIGHT
            )
            
            // Current robot shoots RIGHT
            dp[i][1] = max(
                dp[i - 1][0],                      // previous LEFT (no overlap issue)
                dp[i - 1][1] + wallsFromPrevRight  // extend previous RIGHT
            )
        }
        
        // Step 6: Handle last robot shooting RIGHT
        let lastRobot = robots[robotCount - 1]
        let lastRightContribution = countWalls(
            inRange: lastRobot.position + 1,
            lastRobot.position + lastRobot.shootingDistance
        )
        
        let maxDestroyedWalls = max(
            dp[robotCount - 1][0],
            dp[robotCount - 1][1] + lastRightContribution
        )
        
        return guaranteedDestroyedWalls + maxDestroyedWalls
    }
}


// MARK: - Binary Search Helper
extension Array {
    
    /// Returns the first index where predicate becomes true (lower_bound style)
    func partitioningIndex(where predicate: (Element) -> Bool) -> Int {
        var left = 0
        var right = count
        
        while left < right {
            let mid = left + (right - left) / 2
            
            if predicate(self[mid]) {
                right = mid
            } else {
                left = mid + 1
            }
        }
        
        return left
    }
}
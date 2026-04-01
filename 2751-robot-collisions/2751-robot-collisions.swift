class Solution {
    /**
     Problem Summary:
     Given robots with positions, health values, and movement directions,
     simulate collisions between them. When two robots collide:
       - The robot with lower health is destroyed.
       - The robot with higher health loses 1 health.
       - If both have equal health, both are destroyed.
     Return the healths of surviving robots in their original order.

     Strategy:
     - Sort robots by position to process collisions in spatial order.
     - Use a stack to simulate active robots.
     - Push robots onto the stack and resolve collisions when:
         top robot moves right ("R") and next robot moves left ("L").
     - Continuously resolve collisions until no more valid collisions exist.
     - Track updated healths and return surviving ones.

     Time Complexity:
     O(n log n) due to sorting + O(n) collision simulation

     Space Complexity:
     O(n) for stack and sorting indices
     */
    func survivedRobotsHealths(_ positions: [Int], _ healths: [Int], _ directions: String) -> [Int] {
        var stack: [Int] = []                      // Stack of robot indices
        let directionArray = Array(directions)     // Convert directions string to array
        var currentHealths = healths               // Mutable copy of healths
        
        // Sort robot indices based on their positions
        let sortedRobotIndices = positions.indices.sorted {
            positions[$0] < positions[$1]
        }
        
        // Process each robot in order of position
        for currentRobotIndex in sortedRobotIndices {
            stack.append(currentRobotIndex)
            
            // Resolve collisions while the top two robots are moving towards each other
            while stack.count >= 2 {
                let lastIndex = stack[stack.count - 1]
                let secondLastIndex = stack[stack.count - 2]
                
                // Check collision condition: "R" followed by "L"
                if directionArray[secondLastIndex] != "R" || directionArray[lastIndex] != "L" {
                    break
                }
                
                // Pop the two colliding robots
                let rightMovingRobot = stack.removeLast()
                let leftMovingRobot = stack.removeLast()
                
                let rightHealth = currentHealths[leftMovingRobot]
                let leftHealth = currentHealths[rightMovingRobot]
                
                // Determine minimum health (used to identify who survives)
                let minHealth = min(rightHealth, leftHealth)
                
                // Update healths after collision
                for robotIndex in [leftMovingRobot, rightMovingRobot] {
                    if currentHealths[robotIndex] > minHealth {
                        currentHealths[robotIndex] -= 1
                        stack.append(robotIndex) // Survivor goes back to stack
                    } else {
                        currentHealths[robotIndex] = 0 // Robot destroyed
                    }
                }
            }
        }
        
        // Return only surviving robots' healths
        return currentHealths.filter { $0 > 0 }
    }
}
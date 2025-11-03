// Time Complexity: O(N)
// Let N be the number of balloons (the length of the `colors` string).
// 1. Converting the `colors` string to `colorsArray` takes O(N) time.
// 2. We iterate through the `colorsArray` exactly once, which takes O(N) time.
// 3. All operations inside the loop (comparisons, additions, `max`)
//    are O(1) constant time.
// The total time complexity is O(N) + O(N), which simplifies to O(N).

// Space Complexity: O(N)
// 1. `colorsArray` creates a new array of N characters, which
//    takes O(N) space.
// 2. We only use a few other integer variables (`totalMinCost`,
//    `currentGroupSum`, `currentGroupMax`), which use O(1) constant space.
// The space complexity is dominated by the `colorsArray`, resulting in O(N).
class Solution {
    /**
     * Calculates the minimum cost (time) to remove balloons so that
     * no two adjacent balloons are the same color.
     *
     * The strategy is to iterate through the balloons, identifying
     * consecutive groups of the same color. For each group, we must
     * remove all balloons except for the *one* with the highest
     * `neededTime`.
     *
     * Therefore, the cost to remove for any group is:
     * (Sum of all `neededTime` in the group) - (Max `neededTime` in the group)
     */
    func minCost(_ colors: String, _ neededTime: [Int]) -> Int {
        // Convert the string to an array for efficient O(1) index access.
        let colorsArray = Array(colors)
        let n = colorsArray.count
        
        // If there's 1 or 0 balloons, no two are adjacent, so cost is 0.
        if n <= 1 { return 0 }
        
        // `totalMinCost` will accumulate the cost from all groups.
        var totalMinCost = 0
        
        // These variables track the stats for the *current* group
        // of consecutive, same-colored balloons.
        var currentGroupSum = 0
        var currentGroupMax = 0
        
        // Iterate through every balloon.
        for i in 0..<n {
            
            // Check if this balloon is the *last* in its color group.
            // A group ends if:
            // 1. We are at the last balloon in the entire array (i == n - 1)
            // 2. The *next* balloon is a different color.
            if i == n - 1 || colorsArray[i] != colorsArray[i+1] {
                // This is the last balloon in the current group.
                
                // Add this balloon's time to the group stats.
                currentGroupSum += neededTime[i]
                currentGroupMax = max(currentGroupMax, neededTime[i])
                
                // Now that the group is finished, calculate its cost
                // and add it to the total.
                // (Sum of all times) - (The one we keep)
                totalMinCost += (currentGroupSum - currentGroupMax)
                
                // Reset the group stats for the next group.
                currentGroupSum = 0
                currentGroupMax = 0
                
            } else {
                // This balloon is in the *middle* of a group.
                
                // Add its time to the current group sum.
                currentGroupSum += neededTime[i]
                
                // Update the max time seen in this group so far.
                currentGroupMax = max(currentGroupMax, neededTime[i])
            }
        }
        
        return totalMinCost
    }
}
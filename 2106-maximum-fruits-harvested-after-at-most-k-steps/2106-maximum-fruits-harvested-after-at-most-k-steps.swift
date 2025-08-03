// Time Complexity: O(N)
// N is the number of entries in the `fruits` array. The algorithm uses a
// sliding window where the `left` and `right` pointers each traverse the
// N entries at most once.
//
// Space Complexity: O(N)
// The space is required to store the positions and the prefix sums,
// both of which are proportional to N.
class Solution {
    func maxTotalFruits(_ fruits: [[Int]], _ startPos: Int, _ k: Int) -> Int {
        // MARK: - 1. Preprocessing
        // Create separate arrays for positions and prefix sums for easier access.
        let n = fruits.count
        var positions = [Int](repeating: 0, count: n)
        var prefixSums = [Int](repeating: 0, count: n)

        for i in 0..<n {
            positions[i] = fruits[i][0]
            prefixSums[i] = fruits[i][1]
            if i > 0 {
                prefixSums[i] += prefixSums[i - 1]
            }
        }
        
        var maxFruits = 0
        var left = 0

        // MARK: - 2. Sliding Window
        // `right` pointer expands the window; `left` pointer shrinks it.
        // The window [left...right] represents a potential range to collect.
        for right in 0..<n {
            // This inner loop shrinks the window from the left until it's valid.
            // A `while` is used because the window might need to shrink by more than one step.
            while left <= right {
                let leftPos = positions[left]
                let rightPos = positions[right]
                
                // Calculate the minimum steps needed to travel from startPos and
                // collect all fruits in the current window [leftPos...rightPos].
                let stepsNeeded = min(abs(startPos - rightPos), abs(startPos - leftPos)) + (rightPos - leftPos)
                
                if stepsNeeded <= k {
                    // This window is valid, so we can stop shrinking and evaluate it.
                    break
                } else {
                    // Window is too expensive, shrink from the left.
                    left += 1
                }
            }
            
            if left <= right {
                // After ensuring the window is valid, calculate the fruits within it
                // and update our maximum.
                let currentFruits = prefixSums[right] - (left > 0 ? prefixSums[left - 1] : 0)
                maxFruits = max(maxFruits, currentFruits)
            }
        }
        
        return maxFruits
    }
}
// Time Complexity: O(N)
// The algorithm uses a sliding window approach where the `left` and `right`
// pointers each traverse the array of size N at most once.
//
// Space Complexity: O(1)
// The space used by the frequency map (`baskets`) is at most 3,
// which is constant space.
class Solution {
    /// Finds the length of the longest subarray with at most two distinct fruit types.
    func totalFruit(_ fruits: [Int]) -> Int {
        // `baskets` will store the count of each fruit type currently in our window.
        var baskets: [Int: Int] = [:]
        
        // `left` is the starting index of our sliding window.
        var left = 0
        var maxPicked = 0

        // `right` pointer expands the window by iterating through the array.
        for right in 0..<fruits.count {
            // --- 1. Expand the Window ---
            let rightFruit = fruits[right]
            baskets[rightFruit, default: 0] += 1
            
            // --- 2. Shrink the Window ---
            // If we have more than 2 types of fruit, shrink the window from the left
            // until we are back to having 2 types.
            while baskets.count > 2 {
                let leftFruit = fruits[left]
                
                // Decrement the count of the fruit at the left of the window.
                baskets[leftFruit]? -= 1
                
                // If the count drops to zero, remove the fruit type from our basket entirely.
                if baskets[leftFruit] == 0 {
                    baskets.removeValue(forKey: leftFruit)
                }
                
                // Move the left boundary of the window to the right.
                left += 1
            }
            
            // --- 3. Update Max Length ---
            // The current window `[left...right]` is valid (contains <= 2 fruit types).
            // Update our max if this window is the largest found so far.
            maxPicked = max(maxPicked, right-left+1)
        }
        
        return maxPicked
    }
}
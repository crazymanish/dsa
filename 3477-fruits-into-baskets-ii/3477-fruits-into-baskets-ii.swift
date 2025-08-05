// Time Complexity: O(F * B)
// F is the number of fruits and B is the number of baskets.
// The code uses nested loops, iterating through the baskets for each fruit,
// which results in a quadratic runtime.
//
// Space Complexity: O(B)
// A mutable copy of the `baskets` array is created, requiring space
// proportional to the number of baskets.
class Solution {
    /// Attempts to place fruits into baskets and returns the number of unused baskets.
    /// Note: This function returns the count of baskets that were not used,
    /// not the number of fruits that could not be placed.
    func numOfUnplacedFruits(_ fruits: [Int], _ baskets: [Int]) -> Int {
        // Create a mutable copy of the baskets to track which ones are used.
        var baskets = baskets
        
        // Iterate through each fruit to try and find a basket for it.
        for fruit in fruits {
            // For each fruit, scan the baskets from the beginning.
            for i in 0..<baskets.count {
                // This greedy strategy places the fruit in the *first* basket it fits into.
                // For this to be an optimal strategy for placing the most fruits,
                // the baskets array should be sorted beforehand.
                if fruit <= baskets[i] {
                    // Mark the basket as used by setting it to a sentinel value (-1).
                    baskets[i] = -1
                    // Once a basket is found, stop searching for this fruit and move to the next.
                    break
                }
            }
        }
        
        // After attempting to place all fruits, filter for baskets that were never used
        // (i.e., their capacity is still greater than 0) and return their count.
        return baskets.filter { $0 > 0 }.count
    }
}
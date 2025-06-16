// Time Complexity: O(n)
// We iterate through the input array a single time, performing constant-time
// operations at each step. 'n' is the number of elements in the array.

// Space Complexity: O(1)
// The algorithm uses a fixed amount of extra space for variables,
// regardless of the size of the input array.
class Solution {
    /**
     * Finds the maximum difference between two elements `nums[j] - nums[i]`
     * such that `j > i` and `nums[j] > nums[i]`.
     *
     * - Parameter nums: An array of integers.
     * - Returns: The maximum possible difference, or -1 if no such pair exists.
     */
    func maximumDifference(_ nums: [Int]) -> Int {
        // A difference can only be calculated if there are at least two elements.
        guard nums.count > 1 else { return -1 }
        
        // Initialize with the "not found" state.
        var maxDifference = -1
        
        // Keep track of the smallest number encountered so far. Initialize with the first element.
        var minElementSoFar = nums[0]
        
        // Iterate through the array starting from the second element.
        for i in 1..<nums.count {
            let currentElement = nums[i]
            
            // If the current element is greater than the minimum we've seen,
            // it's a candidate for a valid, positive difference.
            if currentElement > minElementSoFar {
                // Check if this difference is the largest one yet.
                maxDifference = max(maxDifference, currentElement - minElementSoFar)
            }
            
            // Update the minimum element seen so far for future comparisons.
            // We do this after the check to ensure we only use preceding elements for the minimum.
            minElementSoFar = min(minElementSoFar, currentElement)
        }
        
        return maxDifference
    }
}
class Solution {
    /**
     Problem Summary:
     Given an array `nums`, a `target` value, and a starting index `start`,
     find the minimum distance between `start` and any index `i` such that nums[i] == target.

     Strategy:
     - Iterate through the array.
     - For every occurrence of `target`, compute the absolute distance from `start`.
     - Track and return the minimum distance found.

     Time Complexity:
     O(n) — we scan the array once.

     Space Complexity:
     O(1) — no extra space is used beyond variables.
     */
    func getMinDistance(_ nums: [Int], _ target: Int, _ start: Int) -> Int {
        var minimumDistance = Int.max
        
        // Iterate through all indices in the array
        for index in 0..<nums.count {
            // Check if current element matches the target
            if nums[index] == target {
                // Compute distance from start index
                let distance = abs(index - start)
                
                // Update the minimum distance found so far
                minimumDistance = min(minimumDistance, distance)
            }
        }
        
        return minimumDistance
    }
}
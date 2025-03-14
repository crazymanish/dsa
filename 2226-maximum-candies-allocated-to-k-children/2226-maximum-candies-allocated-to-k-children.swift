class Solution {
    func maximumCandies(_ candies: [Int], _ k: Int) -> Int {
        if k == 0 { return 0 } // If there are no children, no candies can be distributed

        var left = 1 // Minimum candies each child can get is 1
        var right = candies.max() ?? 0 // Maximum candies each child can get is the maximum pile size
        var result = 0 // Initialize the result to 0

        // Nested function to check if 'x' candies can be distributed to 'k' children
        func canDistribute(_ x: Int) -> Bool {
            var count = 0 // Initialize the count of children who can receive 'x' candies
            for pile in candies {
                count += pile / x // Calculate how many children can receive 'x' candies from each pile
            }
            return count >= k // Return true if 'k' children can receive 'x' candies
        }

        // Perform binary search to find the maximum candies each child can get
        while left <= right {
            let mid = (left + right) / 2 // Calculate the middle value
            if canDistribute(mid) { // Check if 'mid' candies can be distributed
                result = mid // Update the result with 'mid'
                left = mid + 1 // Search for a larger value
            } else {
                right = mid - 1 // Search for a smaller value
            }
        }

        return result // Return the maximum candies each child can get
    }
}
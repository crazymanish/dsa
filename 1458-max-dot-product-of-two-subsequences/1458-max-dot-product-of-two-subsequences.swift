class Solution {
    func maxDotProduct(_ nums1: [Int], _ nums2: [Int]) -> Int {
        // Build DP along the shorter edge.
        guard nums1.count >= nums2.count else {
            return maxDotProduct(nums2, nums1)
        }
        
        // Fill the first row and the first column with a number
        // that is lower than the minimal result to simplify the DP
        // and ensure it's never used.
        let lowerBound = -1000001
        var previousDP = Array(repeating: lowerBound, count: nums2.count+1)
        
        for i in 1...nums1.count {
            var dp = Array(repeating: 0, count: nums2.count+1)
            dp[0] = lowerBound
            
            for j in 1...nums2.count {
                // Result ignoring i and j product.
                let a = max(previousDP[j], dp[j - 1])
                
                // Result using i and j product.
                let b = max(previousDP[j-1], 0) + nums1[i-1] * nums2[j-1]
                dp[j] = max(a, b)
            }
            
            // Update the previous row.
            previousDP = dp
        }
        
        return previousDP[nums2.count]
    }
}
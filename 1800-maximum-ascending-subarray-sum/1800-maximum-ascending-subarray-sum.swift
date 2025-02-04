class Solution {
    func maxAscendingSum(_ nums: [Int]) -> Int {
        // Initialize the maximum sum and the current sum
        var maxSum = 0
        var currentSum = nums[0]
        
        // Iterate through the array starting from the second element
        for i in 1..<nums.count {
            if nums[i] > nums[i - 1] {
                // If the current element is greater than the previous one,
                // add it to the current sum
                currentSum += nums[i]
            } else {
                // If the current element is not greater, update maxSum if needed
                // and reset currentSum to the current element
                maxSum = max(maxSum, currentSum)
                currentSum = nums[i]
            }
        }
        
        // Final update to maxSum in case the longest ascending subarray is at the end
        maxSum = max(maxSum, currentSum)
        
        return maxSum
    }
}
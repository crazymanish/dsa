class Solution {
    func waysToSplitArray(_ nums: [Int]) -> Int {
        // Calculate the total sum of the array
        let totalSum = nums.reduce(0, +)
    
        // Initialize the left sum and the count of valid splits
        var leftSum = 0
        var count = 0
    
        // Iterate through the array to find valid splits
        for i in 0..<nums.count - 1 {
            // Update the left sum
            leftSum += nums[i]
        
            // Calculate the right sum
            let rightSum = totalSum - leftSum
        
            // Check if the left sum is greater than or equal to the right sum
            if leftSum >= rightSum {
                count += 1
            }
        }
    
        return count
    }
}
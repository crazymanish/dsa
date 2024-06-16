class Solution {
    func minPatches(_ nums: [Int], _ n: Int) -> Int {
        var missingNumber: Int = 1  // The smallest number that cannot be formed
        var patchesCount: Int = 0   // Number of patches (numbers) added
        var index: Int = 0          // Index to iterate through the nums array
        
        // While the missing number is less than or equal to n
        while missingNumber <= n {
            // If the current number in nums can be used to form the missing number
            if index < nums.count && nums[index] <= missingNumber {
                // Use nums[index] to cover the missing number and increment the index
                missingNumber += nums[index]
                index += 1
            } else {
                // Add the missing number itself to the range to cover the gap
                missingNumber += missingNumber
                patchesCount += 1
            }
        }
        
        // Return the number of patches added
        return patchesCount
    }
}
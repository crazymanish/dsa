class Solution {
    func getMaximumXor(_ nums: [Int], _ maximumBit: Int) -> [Int] {
        let maxXorValue = (1 << maximumBit) - 1  // Calculate maximum XOR for maximumBit bits.
        var prefixXOR = 0
        var results = Array(repeating:0, count: nums.count)

        // Compute the cumulative XOR for the entire array.
        for num in nums {
            prefixXOR ^= num
        }
    
        // For each query, get the current prefixXOR and XOR it with maxXorValue.
        for index in 0..<nums.count {
            results[index] = prefixXOR ^ maxXorValue
            // Remove the effect of the last element in prefixXOR for the next iteration.
            prefixXOR ^= nums[results.count-1-index]
        }
    
        return results
    }
}
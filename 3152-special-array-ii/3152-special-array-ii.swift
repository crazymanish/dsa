class Solution {
    func isArraySpecial(_ nums: [Int], _ queries: [[Int]]) -> [Bool] {
        let n = nums.count
        var parityDiff = [Int](repeating: 0, count: n - 1)
        
        // Calculate parity differences
        for i in 0..<n - 1 {
            if (nums[i] % 2) != (nums[i + 1] % 2) {
                parityDiff[i] = 1
            }
        }
        
        // Create a prefix sum array for parity differences
        var prefixSum = [Int](repeating: 0, count: n)
        for i in 1..<n {
            prefixSum[i] = prefixSum[i - 1] + (i < n ? parityDiff[i - 1] : 0)
        }
        
        var results = [Bool]()
        
        // Process each query
        for query in queries {
            let from = query[0]
            let to = query[1]
            let pairCount = to - from
            
            // Calculate the sum of parity differences in the range [from, to-1]
            let paritySum = prefixSum[to] - prefixSum[from]
            
            // Check if the subarray is special
            results.append(paritySum == pairCount)
        }
        
        return results
    }
}
final class Solution {
    /*
     Time Complexity: O(n²)
     - The nested loops check every subarray to find the shortest one with gcd == 1.
     
     Space Complexity: O(1)
     - Only uses constant extra space.
    */
    
    func minOperations(_ nums: [Int]) -> Int {
        let n = nums.count
        
        // Case 1: If there is already a 1, we just need to make other elements 1.
        // Each non-1 element requires one operation with an existing 1.
        if nums.contains(1) {
            let onesCount = nums.filter { $0 == 1 }.count
            return n - onesCount
        }
        
        // Case 2: Find the shortest subarray whose gcd == 1
        var minSubarrayLength = Int.max
        
        for i in 0..<n {
            var currentGCD = nums[i]
            for j in i + 1..<n {
                currentGCD = gcd(currentGCD, nums[j])
                if currentGCD == 1 {
                    // Found a subarray that can generate a 1
                    minSubarrayLength = min(minSubarrayLength, j - i + 1)
                    break // No need to expand further; it's minimal from this start
                }
            }
        }
        
        // If no subarray reduces to gcd == 1, it's impossible
        if minSubarrayLength == Int.max {
            return -1
        }
        
        // Total operations = (steps to create one 1) + (steps to make all others 1)
        // Steps to create one 1 = minSubarrayLength - 1
        // Steps to propagate 1 to all others = n - 1
        return (minSubarrayLength - 1) + (n - 1)
    }
    
    // Helper: compute GCD using Euclidean algorithm
    private func gcd(_ a: Int, _ b: Int) -> Int {
        var x = a, y = b
        while y != 0 {
            let remainder = x % y
            x = y
            y = remainder
        }
        return x
    }
}

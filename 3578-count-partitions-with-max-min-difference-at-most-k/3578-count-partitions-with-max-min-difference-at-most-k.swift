/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • O(n)
///     Each element is pushed and popped from the min/max deque at most once.
///     DP and prefix-sum updates are O(1) each.
///
/// Space Complexity:
///   • O(n)
///     dp array stores n+1 values.
///     Deques store at most n indices.
///
/// Explanation:
///   We count the number of valid partitions such that within any window,
///   the difference between maximum and minimum values does not exceed k.
///
///   Sliding window technique:
///     - maxDeque maintains decreasing indices → front gives window max
///     - minDeque maintains increasing indices → front gives window min
///
///   dp[j] = number of valid partitions ending at index j
///   sum = prefix sum of dp[i...j]
///
///   If window becomes invalid (max - min > k), shrink from left.
/// ---------------------------------------------------------------------------

class Solution {
    func countPartitions(_ nums: [Int], _ k: Int) -> Int {
        let mod = Int(1e9 + 7)
        
        var maxDeque = Deque<Int>()   // stores indices of decreasing nums[]
        var minDeque = Deque<Int>()   // stores indices of increasing nums[]
        
        var dp = [1]                  // dp[0] = 1 (empty prefix)
        var prefixSum = 1             // running sum of dp values for current window
        var left = 0                  // left boundary of sliding window
        
        return nums.indices.reduce(into: dp) { dp, right in
            
            // Maintain monotonic decreasing maxDeque
            while let last = maxDeque.last, nums[right] > nums[last] {
                maxDeque.removeLast()
            }
            maxDeque.append(right)
            
            // Maintain monotonic increasing minDeque
            while let last = minDeque.last, nums[right] < nums[last] {
                minDeque.removeLast()
            }
            minDeque.append(right)
            
            // Shrink window until valid: max - min ≤ k
            while let maxIdx = maxDeque.first,
                  let minIdx = minDeque.first,
                  nums[maxIdx] - nums[minIdx] > k 
            {
                prefixSum = (prefixSum - dp[left] + mod) % mod
                left += 1
                
                // Remove deque elements that slide out of window
                if maxDeque.first! < left { maxDeque.removeFirst() }
                if minDeque.first! < left { minDeque.removeFirst() }
            }
            
            // dp[right+1] = number of valid partitions ending at `right`
            dp.append(prefixSum % mod)
            
            // Add to running prefix sum
            prefixSum = (prefixSum + dp.last!) % mod
            
        }.last!   // final dp value
    }
}

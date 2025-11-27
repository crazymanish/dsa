/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • O(n), where n = nums.count
///     We compute prefix sums and update/look up remainder buckets in O(1)
///     for every element.
///
/// Space Complexity:
///   • O(k)
///     We store one minimum prefix sum for each remainder class (0..k-1).
/// ---------------------------------------------------------------------------
class Solution {
    func maxSubarraySum(_ nums: [Int], _ k: Int) -> Int {
        // Running prefix sum
        var prefixSum = 0
        
        // Result initialized to smallest integer
        var bestResult = Int.min
        
        // cache[r] = smallest prefix sum seen with prefix length % k == r
        // Initialize all to "not seen" except remainder 0 which has a prefix sum of 0
        var minPrefixForRemainder = Array(repeating: Int.max, count: k)
        minPrefixForRemainder[0] = 0
        
        // Iterate through the array while maintaining prefix sum
        for (index, value) in nums.enumerated() {
            prefixSum += value
            
            // Current prefix length
            let currentLength = index + 1
            
            // Remainder category of this prefix length
            let remainder = currentLength % k
            
            // If we have seen a prefix with the same remainder before,
            // then the subarray between those two prefix indices
            // has length % k == 0 (i.e., divisible by k)
            if minPrefixForRemainder[remainder] != Int.max {
                bestResult = max(bestResult, prefixSum - minPrefixForRemainder[remainder])
            }
            
            // Update the smallest prefix sum seen for this remainder bucket
            minPrefixForRemainder[remainder] = min(minPrefixForRemainder[remainder], prefixSum)
        }
        
        return bestResult
    }
}

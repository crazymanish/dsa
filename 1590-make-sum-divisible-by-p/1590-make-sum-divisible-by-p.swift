/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • O(n), where n = nums.count
///     Each element is processed once and dictionary lookups are O(1).
///
/// Space Complexity:
///   • O(p) in the worst case for storing remainders in the dictionary.
///     (But effectively O(n) since remainders come from subarray sums.)
///
/// Problem Summary:
///   Remove the smallest subarray so that the remaining array's sum becomes
///   divisible by p. This is equivalent to removing a subarray whose sum % p
///   equals the totalSum % p.
///
/// Core Idea:
///   Let totalSum % p = k.
///   We want a subarray with sum % p = k so removing it fixes divisibility.
///
///   Using prefix sums:
///     If prefix[i] % p == r,
///     we need a prefix[j] % p == (r - k + p) % p to form such subarray.
///
///   We map prefix remainders → earliest index using a dictionary
///   and try to minimize (i - j).
/// ---------------------------------------------------------------------------
class Solution {
    func minSubarray(_ nums: [Int], _ p: Int) -> Int {
        // Compute total sum remainder.
        let totalSum = nums.reduce(0, +)
        let targetRemainder = totalSum % p
        
        // If already divisible, no need to remove anything.
        if targetRemainder == 0 { return 0 }
        
        // Running prefix sum.
        var prefixSum = 0
        
        // Map: remainder → earliest index where this remainder occurs.
        // Start with remainder 0 at index -1 (empty prefix).
        var earliestIndexForRemainder: [Int: Int] = [0: -1]
        
        var minLength = nums.count
        
        for (index, number) in nums.enumerated() {
            prefixSum += number
            let currentRemainder = prefixSum % p
            
            // We want: (currentRemainder - previousRemainder) % p == targetRemainder
            // → previousRemainder = (currentRemainder - targetRemainder + p) % p
            let neededRemainder = (currentRemainder - targetRemainder + p) % p
            
            if let prevIndex = earliestIndexForRemainder[neededRemainder] {
                minLength = min(minLength, index - prevIndex)
            }
            
            // Update earliest occurrence of this remainder.
            // (We always overwrite, because later index is less useful.)
            earliestIndexForRemainder[currentRemainder] = index
        }
        
        // If minLength == nums.count, we couldn't remove a valid subarray.
        return minLength == nums.count ? -1 : minLength
    }
}

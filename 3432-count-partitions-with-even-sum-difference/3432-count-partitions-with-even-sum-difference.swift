/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • O(n)
///     We compute the total sum once and then track prefix sum in one pass.
///     No array slicing or repeated reductions.
///
/// Space Complexity:
///   • O(1)
///     Only integers for prefix/remaining sums are used.
///
/// Explanation:
///   For each partition index i (where i splits nums into [0...i] and [i+1...]),
///   we compare:
///        leftSum  = sum(nums[0...i])
///        rightSum = sum(nums[i+1...])
///
///   If abs(leftSum - rightSum) is even, we count the partition.
///
///   Since leftSum increases incrementally and rightSum = total - leftSum,
///   we avoid expensive slicing and reduce operations.
/// ---------------------------------------------------------------------------
class Solution {
    func countPartitions(_ nums: [Int]) -> Int {
        let totalSum = nums.reduce(0, +)
        var prefixSum = 0
        var validCount = 0
        
        // Iterate through possible split points (left is nums[0...i])
        for i in 0..<nums.count - 1 {
            prefixSum += nums[i]
            let leftSum = prefixSum
            let rightSum = totalSum - prefixSum
            
            if abs(leftSum - rightSum) % 2 == 0 {
                validCount += 1
            }
        }
        
        return validCount
    }
}

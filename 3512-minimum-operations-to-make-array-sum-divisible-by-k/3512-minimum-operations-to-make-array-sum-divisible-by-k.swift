/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • O(n), where n = nums.count
///     We compute the total sum using a single pass.
///
/// Space Complexity:
///   • O(1)
///     Only constant extra space is used.
///
/// Description:
///   The minimum number of operations needed is simply the remainder of the
///   total sum modulo k, because each operation can increase any element by 1,
///   which increases the total array sum by 1.
///   So we need exactly (sum(nums) % k) operations.
/// ---------------------------------------------------------------------------

class Solution {
    func minOperations(_ nums: [Int], _ k: Int) -> Int {
        // Total amount we need to add to make sum(nums) divisible by k.
        return nums.reduce(0, +) % k
    }
}

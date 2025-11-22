/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • O(n), where n = nums.count
///     We examine each number exactly once.
///
/// Space Complexity:
///   • O(1)
///     Only a constant amount of extra space is used.
///
/// Description:
///   Count how many numbers in the array are NOT divisible by 3.
///   Each such number requires one operation to make divisible.
/// ---------------------------------------------------------------------------

class Solution {
    func minimumOperations(_ nums: [Int]) -> Int {
        var operationCount = 0
        
        for number in nums {
            // If not divisible by 3, we must perform an operation on this number
            if number % 3 != 0 {
                operationCount += 1
            }
        }
        
        return operationCount
    }
}

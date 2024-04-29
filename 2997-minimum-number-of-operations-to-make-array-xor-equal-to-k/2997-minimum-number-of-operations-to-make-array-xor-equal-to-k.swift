class Solution {
    func minOperations(_ nums: [Int], _ k: Int) -> Int {
        String(nums.reduce(k, ^), radix: 2)
            .filter { $0 == "1" }
            .count
    }
}
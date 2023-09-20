class Solution {
    func minOperations(_ nums: [Int], _ x: Int) -> Int {
        var prefixSum = nums.reduce(0,+)
        var leftIndex = 0
        var result = -1
        
        for (rightIndex, num) in nums.enumerated() {
            prefixSum -= num
            while prefixSum < x && leftIndex <= rightIndex {
                prefixSum += nums[leftIndex]
                leftIndex += 1
            }
            
            if prefixSum == x {
				result = max(result, rightIndex-leftIndex+1)
			}
        }
        
        return result == -1 ? result : nums.count-result
    }
}
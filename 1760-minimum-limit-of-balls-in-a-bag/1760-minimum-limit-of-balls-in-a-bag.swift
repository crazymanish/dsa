class Solution {
    func minimumSize(_ nums: [Int], _ maxOperations: Int) -> Int {
        var left = 1
        var right = nums.max()!
        var result = right
        
        func canDivide(_ nums: [Int], _ maxOperations: Int, _ maxBalls: Int) -> Bool {
            var operations = 0
            for num in nums {
                if num > maxBalls {
                    operations += (num - 1) / maxBalls
                }
            }
            return operations <= maxOperations
        }
    
        while left <= right {
            let mid = (left + right) / 2
            if canDivide(nums, maxOperations, mid) {
                result = mid
                right = mid - 1
            } else {
                left = mid + 1
            }
        }
    
        return result
    }
}
class Solution {
    func maxSumOfThreeSubarrays(_ nums: [Int], _ k: Int) -> [Int] {
        let n = nums.count
        var sum = [Int](repeating: 0, count: n + 1)
        var left = [Int](repeating: 0, count: n)
        var right = [Int](repeating: 0, count: n)
    
        // Calculate the prefix sum
        for i in 0..<n {
            sum[i + 1] = sum[i] + nums[i]
        }
    
        // Calculate the best left subarray sums
        var total = sum[k] - sum[0]
        for i in k..<n {
            if sum[i + 1] - sum[i + 1 - k] > total {
                total = sum[i + 1] - sum[i + 1 - k]
                left[i] = i + 1 - k
            } else {
                left[i] = left[i - 1]
            }
        }
    
        // Calculate the best right subarray sums
        right[n - k] = n - k
        total = sum[n] - sum[n - k]
        for i in stride(from: n - k - 1, through: 0, by: -1) {
            if sum[i + k] - sum[i] >= total {
                total = sum[i + k] - sum[i]
                right[i] = i
            } else {
                right[i] = right[i + 1]
            }
        }
    
        // Find the maximum sum by iterating through the middle subarray
        var maxSum = 0
        var result = [-1, -1, -1]
        for i in k..<(n - 2 * k + 1) {
            let l = left[i - 1]
            let r = right[i + k]
            total = (sum[i + k] - sum[i]) + (sum[l + k] - sum[l]) + (sum[r + k] - sum[r])
            if total > maxSum {
                maxSum = total
                result = [l, i, r]
            }
        }
    
        return result
    }
}
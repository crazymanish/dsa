class Solution {
    func maxAbsoluteSum(_ nums: [Int]) -> Int {
        var maxSoFar = 0 // Maximum sum encountered so far
        var minSoFar = 0 // Minimum sum encountered so far
        var maxSum = 0 // Overall maximum absolute sum

        for num in nums {
            maxSoFar = max(num, maxSoFar + num) // Kadane's algorithm for maximum subarray sum
            minSoFar = min(num, minSoFar + num) // Kadane's algorithm for minimum subarray sum
            maxSum = max(maxSum, abs(maxSoFar), abs(minSoFar)) // Update overall maximum absolute sum
        }

        return maxSum
    }
}
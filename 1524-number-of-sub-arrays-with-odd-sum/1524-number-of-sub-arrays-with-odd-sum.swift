class Solution {
    func numOfSubarrays(_ arr: [Int]) -> Int {
        let MOD = 1000000007
        var oddCount = 0
        var evenCount = 1 // Initially, there's one even-sum subarray (the empty subarray)
        var sum = 0
        var result = 0

        for num in arr {
            sum += num
            if sum % 2 == 0 { // If the current sum is even
                result = (result + oddCount) % MOD // Add the count of odd-sum subarrays encountered so far
                evenCount += 1 // Increment the count of even-sum subarrays
            } else { // If the current sum is odd
                result = (result + evenCount) % MOD // Add the count of even-sum subarrays encountered so far
                oddCount += 1 // Increment the count of odd-sum subarrays
            }
        }

        return result
    }
}
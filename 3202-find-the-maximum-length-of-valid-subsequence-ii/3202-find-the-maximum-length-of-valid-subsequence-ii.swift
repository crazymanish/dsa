/*
Time Complexity: `O(n * k)`
The code iterates through each of the **n** numbers in the input array. For each number, it performs an inner loop that runs **k** times. This results in a total time complexity proportional to `n * k`.
---
Space Complexity: `O(k^2)`
The solution uses a 2D array, `dp`, of size `k x k` to store the lengths of subsequences. The space required by this table is the dominant factor, leading to a space complexity of `O(k^2)`.
*/
class Solution {
    func maximumLength(_ nums: [Int], _ k: Int) -> Int {
        // dp[prevRemainder][currRemainder] stores the length of the longest subsequence
        // ending with two numbers whose remainders modulo k are prevRemainder and currRemainder.
        var subsequenceLengths = Array(repeating: Array(repeating: 0, count: k), count: k)
        
        var maxLength = 0

        for num in nums {
            let currentRemainder = num % k

            // Iterate through all possible remainders for the previous element in the subsequence.
            for previousRemainder in 0..<k {
                // The new subsequence ends with (..., previousRemainder, currentRemainder).
                // The length is calculated by extending a subsequence that ended with
                // (..., currentRemainder, previousRemainder) by one.
                // This transition implies a symmetric property in the subsequence rules.
                subsequenceLengths[previousRemainder][currentRemainder] = subsequenceLengths[currentRemainder][previousRemainder] + 1
                
                // Update the overall maximum length found so far.
                maxLength = max(maxLength, subsequenceLengths[previousRemainder][currentRemainder])
            }
        }
        
        return maxLength
    }
}
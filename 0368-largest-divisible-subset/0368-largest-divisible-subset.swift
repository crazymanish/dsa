class Solution {
    func largestDivisibleSubset(_ nums: [Int]) -> [Int] {
        let sortedNums = nums.sorted() // Sort the input array in ascending order
        var divisibleSubsets = Array(repeating: [Int](), count: sortedNums.count) // dp[i] stores the largest divisible subset ending at index i
        var maxSubset = [sortedNums[0]] // Initialize the answer with the first element

        // Iterate through each number in the sorted array
        for i in 0..<sortedNums.count {
            divisibleSubsets[i] = [sortedNums[i]] // Initialize the subset ending at i with the number itself

            // Iterate through the numbers before i to find potential divisible subsets
            for j in 0..<i where sortedNums[i] % sortedNums[j] == 0 {
                // If adding nums[i] to the subset ending at j creates a larger subset
                if divisibleSubsets[j].count + 1 > divisibleSubsets[i].count {
                    divisibleSubsets[i] = divisibleSubsets[j] + [sortedNums[i]] // Extend the subset
                    
                    // Update the answer if the current subset is the largest seen so far
                    if maxSubset.count < divisibleSubsets[i].count {
                        maxSubset = divisibleSubsets[i]
                    }
                }
            }
        }

        return maxSubset // Return the largest divisible subset found
    }
}
class Solution {
    func findNumberOfLIS(_ nums: [Int]) -> Int {
	    // If the array is empty, just return 0 
	    if nums.isEmpty { return 0 }
	
	    // dp[i].0 is the length of the longest increasing subsequence (LIS) including nums[i]
	    // dp[i].1 is the number of subsequences of that length 
	    var dp = Array(repeating: (0, 0), count: nums.count)
	
	    // For a non-empty array the longest subsequence is at least one
	    var longestLISLength = 1

	    for (index, num) in nums.enumerated() {
		    // current is longest subsequence seen for num
		    // count is how many subsequences have curr length
		    var currentLISLength = 1 
		    var countOfCurrentLISLength = 1 
		
		    // Compute curr and count for the current number 
		    for currentIndex in 0 ..< index where nums[currentIndex] < num {
			    let length = dp[currentIndex].0 + 1

			    // Longest subsequence => reset count 
			    if length > currentLISLength {
				    currentLISLength = length
				    countOfCurrentLISLength = 0
			    } 

			    // Ties longest subsequence => increment count 
			    if length == currentLISLength {
				    countOfCurrentLISLength += dp[currentIndex].1
			    }
		    }
		
		    // Store the result in dp[index] 
		    dp[index] = (currentLISLength, countOfCurrentLISLength)
		    longestLISLength = max(longestLISLength, currentLISLength)
	    }

	    // Count how many times the largest sequence occurred
	    return dp.reduce(0) { ($1.0 == longestLISLength) ? $0 + $1.1 : $0 }
    }
}
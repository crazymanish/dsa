class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(n * √m)
    ///     - n = nums.count
    ///     - m = maximum value in nums
    ///     Each number is checked for divisors up to its square root.
    ///
    /// Space Complexity:
    ///   • O(1)
    ///     Only constant extra variables are used.
    ///
    /// Problem Summary:
    ///   For each integer in `nums`, if it has exactly four positive divisors,
    ///   add the sum of those divisors to the final result.
    ///
    /// Key Insight:
    ///   Divisors always come in pairs (d, num / d).
    ///   By iterating only up to √num, we can efficiently find all divisors.
    ///   If more than four divisors are found, we can stop early.
    /// -----------------------------------------------------------------------
    func sumFourDivisors(_ nums: [Int]) -> Int {
        var totalDivisorSum = 0
        
        // Process each number independently
        for value in nums {
            var divisorCount = 0
            var currentDivisorSum = 0
            
            var divisor = 1
            while divisor * divisor <= value {
                if value % divisor == 0 {
                    let pairedDivisor = value / divisor
                    
                    // Count the divisor
                    divisorCount += 1
                    currentDivisorSum += divisor
                    
                    // Count the paired divisor if it's different
                    if divisor != pairedDivisor {
                        divisorCount += 1
                        currentDivisorSum += pairedDivisor
                    }
                    
                    // If more than four divisors are found,
                    // this number cannot be valid
                    if divisorCount > 4 {
                        currentDivisorSum = 0
                        break
                    }
                }
                divisor += 1
            }
            
            // Only add to result if the number has exactly four divisors
            if divisorCount == 4 {
                totalDivisorSum += currentDivisorSum
            }
        }
        
        return totalDivisorSum
    }
}

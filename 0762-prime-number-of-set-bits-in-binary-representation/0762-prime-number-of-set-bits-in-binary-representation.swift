class Solution {
    /// -----------------------------------------------------------------------
    /// Problem Summary:
    ///   Count how many numbers in the range [left, right]
    ///   have a prime number of set bits (1s) in binary form.
    ///
    /// Strategy:
    ///   - Iterate through each number.
    ///   - Count its set bits using `nonzeroBitCount`.
    ///   - Check if that count is prime.
    ///
    /// Time Complexity:
    ///   • O(n)
    ///     - n = right - left + 1
    ///     - Set bit counting is O(1)
    ///     - Prime check is effectively O(1) (max 32 bits)
    ///
    /// Space Complexity:
    ///   • O(1)
    ///     Only a few variables are used.
    /// -----------------------------------------------------------------------
    func countPrimeSetBits(_ left: Int, _ right: Int) -> Int {
        var currentNumber = left
        var totalPrimeBitCounts = 0
        
        // Iterate through the given range
        while currentNumber <= right {
            
            // Count number of 1 bits in binary representation
            let setBitCount = currentNumber.nonzeroBitCount
            
            // If number of set bits is prime, increment result
            if isPrime(setBitCount) {
                totalPrimeBitCounts += 1
            }
            
            currentNumber += 1
        }
        
        return totalPrimeBitCounts
    }

    /// Determines whether a number is prime.
    /// Uses square-root optimization for efficiency.
    private func isPrime(_ value: Int) -> Bool {
        
        // Numbers <= 1 are not prime
        if value <= 1 { return false }
        
        // 2 is the only even prime
        if value == 2 { return true }
        
        // Exclude other even numbers quickly
        if value % 2 == 0 { return false }
        
        // Only test odd divisors up to sqrt(value)
        var divisor = 3
        while divisor * divisor <= value {
            if value % divisor == 0 {
                return false
            }
            divisor += 2
        }
        
        return true
    }
}

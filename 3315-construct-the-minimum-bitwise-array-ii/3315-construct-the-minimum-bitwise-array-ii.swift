class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(n * log m)
    ///     - n = nums.count
    ///     - m = maximum value in nums
    ///     For each number, we scan its binary representation.
    ///
    /// Space Complexity:
    ///   • O(n)
    ///     Result array storing one value per input element.
    ///
    /// Problem Summary:
    ///   For each number x in nums, find an integer i such that:
    ///
    ///       i | (i + 1) == x
    ///
    ///   If no such i exists, return -1 for that number.
    ///
    /// Key Insight:
    ///   - The equation i | (i + 1) = x holds only when x is odd.
    ///   - We need to subtract the smallest power of two (2^k)
    ///     that flips the lowest block of consecutive 1s in x.
    ///
    ///   This is achieved by finding the lowest zero bit
    ///   after a run of trailing 1s in x.
    /// -----------------------------------------------------------------------
    func minBitwiseArray(_ nums: [Int]) -> [Int] {
        return nums.map { value in
            // Special case: 2 has no valid solution
            if value == 2 { return -1 }
            
            var shiftedValue = value
            var powerOfTwo = 1
            
            // Traverse bits from least significant upwards
            // until we find a zero bit after consecutive ones
            while shiftedValue > 0 {
                shiftedValue >>= 1
                if shiftedValue % 2 == 0 {
                    break
                }
                powerOfTwo <<= 1
            }
            
            // Subtract the identified power of two
            return value - powerOfTwo
        }
    }
}

/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • O(n), where n = nums.count
///     We process each bit once.
///
/// Space Complexity:
///   • O(n) for the resulting boolean array.
///     The intermediate accumulator uses only O(1).
///
/// Description:
///   We treat the bits as a growing binary number. Instead of keeping the
///   entire number (which would overflow), we keep it modulo 100 since we
///   only care about whether it's divisible by 5:
///       value = (value * 2 + bit) % 100
///
///   A number is divisible by 5 iff value % 5 == 0.
/// ---------------------------------------------------------------------------

class Solution {
    func prefixesDivBy5(_ nums: [Int]) -> [Bool] {
        var currentValue = 0
        var result = [Bool]()
        
        for bit in nums {
            // Update running binary value (mod 100 to keep number small)
            currentValue = (currentValue * 2 + bit) % 100
            
            // Check divisibility by 5
            result.append(currentValue % 5 == 0)
        }
        
        return result
    }
}

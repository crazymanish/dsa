/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • O(n), where n = digits.count
///     In the worst case (all 9s), we scan the entire array.
///
/// Space Complexity:
///   • O(1) extra space
///     The result is modified in place (ignoring output storage).
///
/// Problem Summary:
///   Given a non-empty array of digits representing a non-negative integer,
///   increment the integer by one and return the resulting digits.
///
/// Approach:
///   - Start from the least significant digit.
///   - If the digit is less than 9, increment and return immediately.
///   - If the digit is 9, set it to 0 and continue carrying.
///   - If all digits are 9, prepend 1.
/// ---------------------------------------------------------------------------

class Solution {
    func plusOne(_ digits: [Int]) -> [Int] {
        var result = digits
        
        // Process digits from right to left
        for index in stride(from: result.count - 1, through: 0, by: -1) {
            if result[index] < 9 {
                result[index] += 1
                return result
            }
            
            // Carry over
            result[index] = 0
        }
        
        // All digits were 9 (e.g., 999 -> 1000)
        result.insert(1, at: 0)
        return result
    }
}

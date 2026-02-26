class Solution {
    /// -----------------------------------------------------------------------
    /// Problem Summary:
    ///   Given a binary string `s`, reduce it to "1" using:
    ///     • If even → divide by 2
    ///     • If odd  → add 1
    ///
    ///   Return the number of steps required.
    ///
    /// Strategy:
    ///   Traverse from right to left.
    ///   Simulate binary addition using a carry.
    ///
    /// Time Complexity:
    ///   • O(n)
    ///     We scan the string once.
    ///
    /// Space Complexity:
    ///   • O(1)
    ///     Only constant variables are used.
    /// -----------------------------------------------------------------------
    func numSteps(_ s: String) -> Int {
        var steps = 0
        var carry = 0
        
        // Traverse from right to left (skip first character)
        for index in stride(from: s.count - 1, to: 0, by: -1) {
            let currentBit = (s[s.index(s.startIndex, offsetBy: index)] == "1") ? 1 : 0
            let sum = currentBit + carry
            
            if sum % 2 == 1 {
                // Odd → add 1 (becomes even), then divide
                steps += 2
                carry = 1
            } else {
                // Even → divide by 2
                steps += 1
            }
        }
        
        // If carry remains at MSB
        return steps + carry
    }
}
/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • O(n), where n = bits.count
///     We scan through the array once, moving by 1 or 2 positions.
///
/// Space Complexity:
///   • O(1)
///     Only a constant number of variables are used.
///
/// Description:
///   A '1' indicates a two-bit character (10 or 11), so we skip 2 positions.
///   A '0' indicates a one-bit character, so we move 1 position.
///
///   The question: Is the last character a one-bit character?
///   This is true only if we land exactly on the last index after parsing.
/// ---------------------------------------------------------------------------
class Solution {
    func isOneBitCharacter(_ bits: [Int]) -> Bool {
        var index = 0
        
        // Process characters until the second-to-last position
        while index < bits.count - 1 {
            if bits[index] == 1 {
                // '1' means this character spans bits[index] and bits[index + 1]
                index += 2
            } else {
                // '0' forms a single-bit character
                index += 1
            }
        }
        
        // If we stopped exactly at the last index, the last char is one-bit
        return index == bits.count - 1
    }
}

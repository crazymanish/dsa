class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(max(n, m))
    ///     - n = a.count
    ///     - m = b.count
    ///     We iterate once from right to left.
    ///
    /// Space Complexity:
    ///   • O(max(n, m))
    ///     - Result array stores the binary sum.
    ///
    /// Problem Summary:
    ///   Add two binary strings and return their sum as a binary string.
    ///
    /// Approach:
    ///   - Traverse both strings from right to left.
    ///   - Add corresponding bits plus carry.
    ///   - Store result in reverse order.
    ///   - Reverse at the end.
    /// -----------------------------------------------------------------------
    func addBinary(_ a: String, _ b: String) -> String {
        let aChars = Array(a)
        let bChars = Array(b)
        
        var pointerA = aChars.count - 1
        var pointerB = bChars.count - 1
        
        var carry = 0
        var reversedResult = [Character]()
        
        // Continue while either string has remaining bits
        while pointerA >= 0 || pointerB >= 0 {
            
            let bitA = pointerA >= 0
                ? Int(aChars[pointerA].asciiValue! - Character("0").asciiValue!)
                : 0
            
            let bitB = pointerB >= 0
                ? Int(bChars[pointerB].asciiValue! - Character("0").asciiValue!)
                : 0
            
            let sum = bitA + bitB + carry
            
            // Current result bit
            let resultBit = sum % 2
            reversedResult.append(resultBit == 0 ? "0" : "1")
            
            // Update carry
            carry = sum / 2
            
            pointerA -= 1
            pointerB -= 1
        }
        
        // Append leftover carry if exists
        if carry == 1 {
            reversedResult.append("1")
        }
        
        // Reverse to get final binary string
        return String(reversedResult.reversed())
    }
}
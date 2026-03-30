class Solution {
    /**
     Problem Summary:
     Given two strings `s1` and `s2` of equal length, determine if they can be made equal
     by swapping characters only among indices of the same parity (even indices with even,
     odd indices with odd).

     Strategy:
     - Traverse both strings simultaneously.
     - Maintain two frequency maps:
       1. Even index characters difference
       2. Odd index characters difference
     - For each index:
         - Increment count for `s1` character
         - Decrement count for `s2` character
     - If both frequency maps resolve to all zeros, the strings are equivalent under the allowed swaps.

     Time Complexity:
     O(n) — single pass through the strings

     Space Complexity:
     O(1) — bounded by character set size (at most 26 for lowercase letters)
     */
    func checkStrings(_ s1: String, _ s2: String) -> Bool {
        let targetCharacters = Array(s2)
        
        // Frequency differences for even and odd indices
        var (evenIndexDiff, oddIndexDiff) = ([Character: Int](), [Character: Int]())
        
        // Iterate through s1 with index
        for (index, char) in s1.enumerated() {
            let targetChar = targetCharacters[index]
            
            if index % 2 == 0 {
                // Update even index frequency difference
                evenIndexDiff[char, default: 0] += 1
                evenIndexDiff[targetChar, default: 0] -= 1
            } else {
                // Update odd index frequency difference
                oddIndexDiff[char, default: 0] += 1
                oddIndexDiff[targetChar, default: 0] -= 1
            }
        }
        
        // Validate all frequency differences are zero
        let isEvenBalanced = evenIndexDiff.values.allSatisfy { $0 == 0 }
        let isOddBalanced = oddIndexDiff.values.allSatisfy { $0 == 0 }
        
        return isEvenBalanced && isOddBalanced
    }
}
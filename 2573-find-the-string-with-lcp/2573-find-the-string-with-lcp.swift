class Solution {
    /**
     Problem Summary:
     Given an LCP (Longest Common Prefix) matrix, reconstruct a string such that
     lcp[i][j] represents the length of the longest common prefix between
     suffixes starting at index i and j.

     Strategy:
     1. Validate diagonal:
        - lcp[i][i] must equal n - i (full suffix length).
     
     2. Construct the string:
        - Assign characters greedily.
        - If lcp[i][j] > 0, then characters at i and j must match.
        - Group such indices under the same character.
     
     3. Validate reconstruction:
        - Recompute expected LCP values using the constructed string.
        - Compare against the given matrix.

     Time Complexity:
     O(n^2)

     Space Complexity:
     O(n)
     */
    func findTheString(_ lcp: [[Int]]) -> String {
        let stringLength = lcp.count
        
        // Step 1: Validate diagonal values
        // Each suffix compared with itself must equal its full remaining length
        for index in 0..<stringLength {
            if lcp[index][index] != stringLength - index {
                return ""
            }
        }
        
        // Step 2: Assign characters to each position
        // characterGroup[i] represents which character index (1...26) is assigned to position i
        var characterGroup = Array(repeating: 0, count: stringLength)
        
        // Tracks the next available character (1 -> 'a', 2 -> 'b', ...)
        var nextCharacterCode = 1
        
        for baseIndex in 0..<stringLength {
            // Skip if this position already has an assigned character
            if characterGroup[baseIndex] != 0 { continue }
            
            // We only have 26 lowercase English letters
            if nextCharacterCode > 26 { return "" }
            
            // Assign the same character to all indices that must match this position
            for compareIndex in 0..<stringLength {
                // If LCP > 0, the first character of both suffixes must be equal
                if lcp[compareIndex][baseIndex] > 0 {
                    
                    if characterGroup[compareIndex] == 0 {
                        // Assign this group character
                        characterGroup[compareIndex] = nextCharacterCode
                    } else if characterGroup[compareIndex] != nextCharacterCode {
                        // Conflict: same position requires two different characters
                        return ""
                    }
                }
            }
            
            // Move to next character for the next group
            nextCharacterCode += 1
        }
        
        // Convert numeric groups into actual characters
        let constructedString = String(
            characterGroup.map { Character(UnicodeScalar($0 + 96)!) }
        )
        
        let characters = Array(constructedString)
        
        // Step 3: Validate by recomputing expected LCP values
        // Traverse from bottom-right to reuse previously validated values
        for i in stride(from: stringLength - 1, through: 0, by: -1) {
            for j in stride(from: stringLength - 1, through: 0, by: -1) {
                
                var expectedLCPValue = 0
                
                // If characters match, LCP is at least 1
                if characters[i] == characters[j] {
                    
                    if i + 1 < stringLength && j + 1 < stringLength {
                        // Extend LCP using next suffix positions
                        expectedLCPValue = 1 + lcp[i + 1][j + 1]
                    } else {
                        // At least one suffix ends here
                        expectedLCPValue = 1
                    }
                }
                
                // If mismatch with given matrix, reconstruction is invalid
                if lcp[i][j] != expectedLCPValue {
                    return ""
                }
            }
        }
        
        return constructedString
    }
}
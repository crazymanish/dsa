class Solution {
    /// -----------------------------------------------------------------------
    /// Problem Summary:
    ///   A special binary string:
    ///     • Contains equal number of '1's and '0's
    ///     • Every prefix has #1 ≥ #0
    ///
    ///   We can split a special string into smaller special substrings.
    ///   The goal is to rearrange these substrings to obtain the
    ///   lexicographically largest possible special string.
    ///
    /// Strategy:
    ///   1. A special string can be decomposed into top-level blocks of the form:
    ///         "1" + inner_special + "0"
    ///   2. Recursively optimize each inner_special.
    ///   3. Sort all top-level blocks in descending lexicographic order.
    ///   4. Concatenate them.
    ///
    /// Time Complexity:
    ///   • O(n²) worst case
    ///     Deeply nested structures cause repeated substring processing.
    ///
    /// Space Complexity:
    ///   • O(n)
    ///     Recursion stack + temporary block storage.
    /// -----------------------------------------------------------------------
    func makeLargestSpecial(_ input: String) -> String {
        return String(buildLargestSpecial(from: input[...]))
    }

    /// Recursively builds the lexicographically largest special string
    /// from a special substring.
    private func buildLargestSpecial(from substring: Substring) -> Substring {
        
        var balanceCounter = 0
        var blockStartIndex = substring.startIndex
        var specialBlocks = [Substring]()
        
        var currentIndex = substring.startIndex
        
        // Traverse the substring to identify top-level special blocks
        while currentIndex < substring.endIndex {
            
            // Update balance: +1 for '1', -1 for '0'
            balanceCounter += (substring[currentIndex] == "1") ? 1 : -1
            
            // When balance returns to 0, we found a complete special block
            if balanceCounter == 0 {
                
                let nextIndex = substring.index(after: currentIndex)
                
                // Extract the inner substring (excluding outer 1 and 0)
                let innerStart = substring.index(after: blockStartIndex)
                let innerEnd = currentIndex
                
                let innerSubstring =
                    buildLargestSpecial(from: substring[innerStart..<innerEnd])
                
                // Reconstruct full special block
                let reconstructedBlock = "1" + innerSubstring + "0"
                specialBlocks.append(Substring(reconstructedBlock))
                
                // Move start pointer to next block
                blockStartIndex = nextIndex
            }
            
            currentIndex = substring.index(after: currentIndex)
        }

        // Sort blocks in descending order to maximize lexicographic result
        specialBlocks.sort(by: >)
        
        // Join all blocks into a single result
        return Substring(specialBlocks.joined())
    }
}

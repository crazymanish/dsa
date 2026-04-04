class Solution {
    /**
     Problem Summary:
     Given an encoded string written row-wise in a matrix with `rows` rows,
     reconstruct the original message by reading diagonally (top-left → bottom-right).
     Trailing spaces in the final decoded string should be removed.

     Strategy:
     1. Compute number of columns needed to fit the string into a matrix.
     2. Treat the string as a row-major flattened matrix.
     3. For each starting column, traverse diagonally (row++, col++).
     4. Collect characters while ensuring indices are within bounds.
     5. Trim trailing spaces from the final result.

     Time Complexity:
     O(n) — Each character is visited at most once.

     Space Complexity:
     O(n) — Result array and character array storage.
     */
    func decodeCiphertext(_ encodedText: String, _ rowCount: Int) -> String {
        // Edge case: empty string
        if encodedText.isEmpty { return encodedText }
        
        let totalLength = encodedText.count
        let columnCount = (totalLength + rowCount - 1) / rowCount
        
        let characters = Array(encodedText)
        var decodedCharacters: [Character] = []
        
        // Traverse each starting column
        for startColumn in 0..<columnCount {
            var currentRow = 0
            var currentColumn = startColumn
            
            // Traverse diagonally down-right
            while currentRow < rowCount && currentColumn < columnCount {
                let index = currentRow * columnCount + currentColumn
                
                // Ensure index is within bounds of original string
                if index < totalLength {
                    decodedCharacters.append(characters[index])
                }
                
                currentRow += 1
                currentColumn += 1
            }
        }
        
        // Remove trailing spaces
        var lastValidIndex = decodedCharacters.count - 1
        while lastValidIndex >= 0 && decodedCharacters[lastValidIndex] == " " {
            lastValidIndex -= 1
        }
        
        // Construct final string
        return lastValidIndex >= 0 ? String(decodedCharacters[0...lastValidIndex]) : ""
    }
}
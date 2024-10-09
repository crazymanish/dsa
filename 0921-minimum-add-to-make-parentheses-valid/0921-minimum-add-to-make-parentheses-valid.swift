class Solution {
    func minAddToMakeValid(_ s: String) -> Int {
        var missingOpen = 0   // count of missing open parens "("
        var missingClosed = 0 // count of missing closed parens ")"
    
        for char in s {
            missingOpen += char == "("  ? 1:-1
            if missingOpen < 0 {
                missingClosed += 1
                missingOpen = 0
            }
        }
    
        return missingOpen + missingClosed
    }
}
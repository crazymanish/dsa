class Solution {
    func appendCharacters(_ s: String, _ t: String) -> Int {
        // Initialize two pointers: one for string s and one for the longest prefix of t found in s
        var sIndex = s.startIndex
        var tIndex = t.startIndex
        
        // Loop through the characters of s and t
        while sIndex < s.endIndex && tIndex < t.endIndex {
            // Check if the current characters of s and t are equal
            if s[sIndex] == t[tIndex] {
                // If they are equal, move the tIndex to the next character of t
                tIndex = t.index(after: tIndex)
            }
            // Move the sIndex to the next character of s
            sIndex = s.index(after: sIndex)
        }
        
        // Calculate the number of characters needed to append to t to match the remaining part
        return t.distance(from: tIndex, to: t.endIndex)
    }
}
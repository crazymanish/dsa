class Solution {
    /**
     Problem Summary:
     Determine if string `goal` can be obtained by repeatedly rotating string `s`.
     A rotation means moving the first character to the end.

     Strategy:
     - If lengths differ → impossible.
     - Repeatedly rotate the string by moving the first character to the end.
     - Stop when:
       1. We match `goal` → return true
       2. We return back to original string → all rotations exhausted → return false

     Time Complexity:
     O(n^2)
     - Each rotation is O(n) due to string operations
     - Up to n rotations

     Space Complexity:
     O(n)
     - Temporary string copies during rotation
     */
    func rotateString(_ s: String, _ goal: String) -> Bool {
        // If lengths differ, rotation cannot match
        guard s.count == goal.count else { return false }

        var rotatedString = s

        while true {
            // Remove first character and append it to the end
            let firstCharacter = String(rotatedString.removeFirst())
            rotatedString += firstCharacter

            // Check if current rotation matches target
            if rotatedString == goal {
                return true
            }

            // If we've returned to original string, all rotations are exhausted
            if rotatedString == s {
                return false
            }
        }
    }
}
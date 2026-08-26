class Solution {
    /**
     Problem Summary:
     Find the shortest substring of `s` containing exactly `k` occurrences of "1".
     If multiple substrings have the same minimum length, return the
     lexicographically smallest one.

     Strategy:
     - Use a sliding window with `left` and `right` pointers.
     - Track the number of "1"s currently inside the window.
     - Whenever the window contains exactly `k` ones, it is a valid candidate.
     - Keep shrinking from the left while the window remains valid.
     - Update the answer when the candidate is shorter, or when it has the
       same length but is lexicographically smaller.

     Time Complexity:
     O(n²) in the worst case because creating and comparing candidate Strings
     can take O(n), even though the sliding-window traversal itself is O(n).

     Space Complexity:
     O(n) because the input String is converted into a Character array.
     */
    func shortestBeautifulSubstring(_ s: String, _ k: Int) -> String {
        let characters = Array(s)
        let length = characters.count

        var shortestSubstring = ""
        var oneCount = 0
        var left = 0

        for right in 0..<length {
            // Expand the window and count the new "1", if present.
            if characters[right] == "1" {
                oneCount += 1
            }

            // A window is beautiful when it contains exactly k ones.
            // Shrinking from the left lets us find the shortest valid
            // candidate ending at `right`.
            while oneCount == k && left <= right {
                let candidate = String(characters[left...right])
                let candidateLength = right - left + 1

                // For equal lengths, choose the lexicographically smaller one.
                if shortestSubstring.isEmpty ||
                    candidateLength < shortestSubstring.count ||
                    (candidateLength == shortestSubstring.count &&
                     candidate < shortestSubstring) {
                    shortestSubstring = candidate
                }

                // Remove the leftmost character before shrinking the window.
                if characters[left] == "1" {
                    oneCount -= 1
                }

                left += 1
            }
        }

        return shortestSubstring
    }
}
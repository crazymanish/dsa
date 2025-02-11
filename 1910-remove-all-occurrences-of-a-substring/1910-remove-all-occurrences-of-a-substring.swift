class Solution {
    func removeOccurrences(_ s: String, _ part: String) -> String {
        var mutableS = s // Make s mutable

        while let range = mutableS.range(of: part) { // Find the leftmost occurrence
            mutableS.removeSubrange(range) // Remove the part
        }

        return mutableS // Return the modified string
    }
}
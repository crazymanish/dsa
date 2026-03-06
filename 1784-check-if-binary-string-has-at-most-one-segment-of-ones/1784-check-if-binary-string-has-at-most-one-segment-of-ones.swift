class Solution {
    /**
     -----------------------------------------------------------------------
     Problem Summary:
       Given a binary string `s`, determine whether all the `'1'`s in the
       string appear in exactly one contiguous segment.

       In other words, once a `'0'` appears after a `'1'`, there must not
       be another `'1'` later in the string.

     Strategy:
       1. Convert the string into an array for index-based access.
       2. Locate the first occurrence of `'1'`.
       3. Locate the last occurrence of `'1'`.
       4. If no `'1'` exists, return `false`.
       5. Verify that every character between the first and last `'1'`
          is also `'1'`.
       6. If any `'0'` appears in that range, the ones are split into
          multiple segments.

     Time Complexity:
       O(n)
       - Finding first and last index takes O(n)
       - Verifying the segment takes O(n)

     Space Complexity:
       O(n)
       - Conversion from String → Array<Character>
     -----------------------------------------------------------------------
     */

    func checkOnesSegment(_ s: String) -> Bool {
        // Convert string to array to allow index-based access
        let characters = Array(s)

        // Locate the first and last occurrence of '1'
        let firstOneIndex = characters.firstIndex(of: "1")
        let lastOneIndex = characters.lastIndex(of: "1")

        // If there are no '1's in the string, return false
        guard let start = firstOneIndex, let end = lastOneIndex else {
            return false
        }

        // Verify that all characters between first and last '1' are '1'
        for index in start...end {
            if characters[index] != "1" {
                // Found a '0' inside the segment → multiple segments of '1'
                return false
            }
        }

        return true
    }
}
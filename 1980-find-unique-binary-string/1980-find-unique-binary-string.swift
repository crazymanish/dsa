/**
 Problem Summary
 ----------------
 We are given an array `nums` containing `n` unique binary strings,
 each of length `n`. We must return any binary string of length `n`
 that does NOT appear in `nums`.

 Strategy
 --------
 Use **Cantor's Diagonal Argument**.

 Construct a new binary string by examining the `i-th` character of
 the `i-th` string and flipping it:
    - If nums[i][i] == '0' → put '1'
    - If nums[i][i] == '1' → put '0'

 This guarantees the generated string differs from every string in
 `nums` at least at position `i`.

 Therefore, the constructed string cannot exist in the input set.

 Key Insight
 -----------
 The result differs from:
    nums[0] at index 0
    nums[1] at index 1
    nums[2] at index 2
    ...
 So it is guaranteed to be unique.

 Time Complexity
 ---------------
 O(n)

 We iterate through `nums` once and inspect one character per string.

 Space Complexity
 ----------------
 O(n)

 We construct a result string of length `n`.
 */
class Solution {
    func findDifferentBinaryString(_ nums: [String]) -> String {
        var result = ""

        for (index, binaryString) in nums.enumerated() {
            let currentBit = binaryString[binaryString.index(binaryString.startIndex, offsetBy: index)]

            // Flip the diagonal bit
            if currentBit == "0" {
                result.append("1")
            } else {
                result.append("0")
            }
        }

        return result
    }
}
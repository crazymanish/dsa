class Solution {
    /**
     -----------------------------------------------------------------------
     Problem Summary:
        Given a binary string `s` and an integer `k`,
        determine the minimum number of operations required.

        Each operation affects exactly `k` positions.
        The parity (even or odd count) of total operations matters.

        The solution is constrained by:
        • Total zero count
        • String length
        • Parity relationships between zero count and k

     Strategy:
        1. Count total number of '0's in the string.
        2. Handle the special case when the entire string is affected in
           a single operation (length == k).
        3. Otherwise evaluate two valid parity scenarios:

           Case A:
              - Make total operations even.
              - Requires zeroCount to be even.

           Case B:
              - Make total operations odd.
              - Requires zeroCount parity == k parity.

        4. For each valid scenario:
              - Compute the minimum required operations using ceiling division.
              - Adjust the result to satisfy required parity.
              - Track the global minimum.

     Time Complexity:
        O(n)
        - Counting zeros requires a full scan.

     Space Complexity:
        O(1)
        - Only a few integer variables are used.
     -----------------------------------------------------------------------
     */

    /// Performs ceiling division without using floating point.
    private func ceilDivide(_ numerator: Int, _ denominator: Int) -> Int {
        return (numerator + denominator - 1) / denominator
    }

    func minOperations(_ s: String, _ k: Int) -> Int {
        let length = s.count
        let zeroCount = s.filter { $0 == "0" }.count

        // Special Case:
        // If one operation affects the entire string.
        if length == k {
            if zeroCount == 0 {
                return 0          // Already satisfies condition
            } else if zeroCount == length {
                return 1          // One full flip
            } else {
                return -1         // Impossible to fix partially
            }
        }

        let infinity = Int.max
        var minimumOperations = infinity

        // ------------------------------------------------------------
        // Case 1:
        // Zero count is even → total operations must be even.
        // ------------------------------------------------------------
        if zeroCount % 2 == 0 {

            // We must satisfy both constraints:
            //   - Fix zeroCount
            //   - Respect the unaffected segment (length - k)
            var operations =
                max(
                    ceilDivide(zeroCount, k),
                    ceilDivide(zeroCount, length - k)
                )

            // Ensure total operations is even
            if operations % 2 != 0 {
                operations += 1
            }

            minimumOperations = min(minimumOperations, operations)
        }

        // ------------------------------------------------------------
        // Case 2:
        // zeroCount parity must match k parity → operations must be odd.
        // ------------------------------------------------------------
        if zeroCount % 2 == k % 2 {

            var operations =
                max(
                    ceilDivide(zeroCount, k),
                    ceilDivide(length - zeroCount, length - k)
                )

            // Ensure total operations is odd
            if operations % 2 == 0 {
                operations += 1
            }

            minimumOperations = min(minimumOperations, operations)
        }

        return minimumOperations == infinity ? -1 : minimumOperations
    }
}
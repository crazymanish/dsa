class Solution {
    /**
     Finds all unique 3-digit even numbers that can be formed using the digits
     from the input array, without using any digit more times than it appears
     in the input.

     - Parameter digits: An array of single integers (0-9).
     - Returns: A sorted array of unique 3-digit even numbers that can be formed.

     --- Overall Complexity Analysis ---

     Let N be the number of elements in the input `digits` array.
     Let M be the number of valid 3-digit even numbers found (M <= 450).

     * Time Complexity: O(N + M log M)
         * Counting input digits frequencies: O(N).
         * Iterating through candidate numbers (100 to 998, step 2): O(450) = O(1) relative to N.
             * Inside the loop, generating required counts and checking availability are both O(1).
         * Sorting the results: O(M log M). Since M is bounded by a constant (450), M log M is also technically constant relative to N.
         * Therefore, the complexity is dominated by the initial count O(N) and the sort O(M log M). If N is very large, O(N) dominates. If N is small, the constant work (including sorting) might dominate wall-clock time, but asymptotically it's O(N + M log M), often simplified to O(N) because M log M is bounded by a constant. We'll keep O(N + M log M) for precision.

     * Space Complexity: O(M) or O(1)
         * `availableDigitCounts` dictionary: Stores frequencies for digits 0-9. O(10) = O(1) space.
         * `requiredCounts` dictionary (inside closure): Created per candidate. O(3) = O(1) temporary space per call.
         * `validEvenNumbers` array (output): Stores the found numbers. In the worst case, up to M numbers. O(M) space.
         * Auxiliary space for sorting: `sorted()` might use O(M) or O(log M) auxiliary space depending on the algorithm (often Timsort/Mergesort for non-in-place).
         * The dominant factor is the output array `validEvenNumbers`. So, O(M). Since M <= 450, this is bounded by a constant, thus it can also be considered O(1) space relative to the input size N. We will state O(M) to reflect the dependency on the number of results, acknowledging M is bounded.
     */
    func findEvenNumbers(_ digits: [Int]) -> [Int] {

        // --- Step 1: Count the frequency of available digits ---
        // Create a dictionary to store the count of each digit (0-9).
        // Time: O(N), Space: O(1) (at most 10 keys)
        var availableDigitCounts: [Int: Int] = [:]
        for digit in digits {
            availableDigitCounts[digit, default: 0] += 1
        }

        // --- Step 2: Define Helper Closure for Candidate Digit Counts ---
        // Calculates the frequency of digits required for a given 3-digit number.
        // Time: O(1) per call, Space: O(1) temporary space per call
        let getRequiredDigitCounts = { (number: Int) -> [Int: Int] in
            var requiredCounts: [Int: Int] = [:]
            var tempNumber = number
            // Extract digits
            let unitsDigit = tempNumber % 10; tempNumber /= 10
            let tensDigit = tempNumber % 10;  tempNumber /= 10
            let hundredsDigit = tempNumber
            // Count digits
            requiredCounts[unitsDigit, default: 0] += 1
            requiredCounts[tensDigit, default: 0] += 1
            requiredCounts[hundredsDigit, default: 0] += 1
            return requiredCounts
        }

        // --- Step 3: Iterate and Validate Potential 3-Digit Even Numbers ---
        // Array to store the results. Space: O(M) where M is # results (M <= 450)
        var validEvenNumbers: [Int] = []

        // Iterate through 3-digit even numbers (100, 102, ..., 998).
        // Loop runs a constant 450 times. Time: O(1) relative to N.
        for candidateNumber in stride(from: 100, through: 998, by: 2) {

            // Get required digits. Time: O(1)
            let requiredCounts = getRequiredDigitCounts(candidateNumber)

            // Check if number can be formed. Time: O(1) (max 3 lookups/comparisons)
            var canFormNumber = true
            for (digit, requiredCount) in requiredCounts {
                // Check if available count is sufficient. O(1) dictionary lookup.
                if let availableCount = availableDigitCounts[digit], availableCount >= requiredCount {
                    continue
                } else {
                    canFormNumber = false
                    break
                }
            }

            // Add valid number if possible. Time: O(1) amortized append.
            if canFormNumber {
                validEvenNumbers.append(candidateNumber)
            }
        }

        // --- Step 4: Sort the Results ---
        // `stride` generates numbers in order, making `validEvenNumbers` sorted.
        // However, `sorted()` ensures uniqueness if duplicates could theoretically arise
        // (they can't here) and matches original code's intent.
        // Time: O(M log M), Space: O(M) or O(log M) auxiliary for sort (M <= 450)
        return validEvenNumbers.sorted() // Note: Potentially redundant due to stride. See comments.
    }
}
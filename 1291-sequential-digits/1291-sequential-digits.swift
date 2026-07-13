class Solution {
    /**
     Problem Summary:
     Return all numbers within the range `[low, high]` whose digits are sequential,
     meaning every digit is exactly one greater than the previous digit.

     Strategy:
     - Start with every two-digit sequential number.
     - Process the current candidates in ascending order.
     - Remove the final candidate because it ends in `9` and cannot be extended.
     - Extend each remaining candidate by appending its next sequential digit.
     - Stop immediately once a candidate exceeds `high`, since candidates are generated
       in ascending order.

     Time Complexity:
     O(1), because there are only 36 possible sequential-digit numbers.

     Space Complexity:
     O(1), excluding the returned result.
     */
    func sequentialDigits(_ low: Int, _ high: Int) -> [Int] {
        var sequentialCandidates = [12, 23, 34, 45, 56, 67, 78, 89]
        var validNumbers: [Int] = []

        while !sequentialCandidates.isEmpty {
            // Candidates are generated in ascending order for each digit length.
            for candidate in sequentialCandidates {
                // All remaining candidates will also exceed the upper bound.
                if candidate > high {
                    return validNumbers
                }

                if candidate >= low {
                    validNumbers.append(candidate)
                }
            }

            // The final candidate ends in 9, so it cannot receive another sequential digit.
            sequentialCandidates.removeLast()

            // Extend every remaining number by appending the next sequential digit.
            for index in sequentialCandidates.indices {
                let currentNumber = sequentialCandidates[index]
                let nextDigit = currentNumber % 10 + 1
                sequentialCandidates[index] = currentNumber * 10 + nextDigit
            }
        }

        return validNumbers
    }
}
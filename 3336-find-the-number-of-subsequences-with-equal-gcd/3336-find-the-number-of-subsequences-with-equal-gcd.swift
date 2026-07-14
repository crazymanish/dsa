class Solution {
    /**
     Problem Summary:
     Count the number of ordered pairs of non-empty subsequences whose GCD values
     are equal. Each number may be skipped, added to the first subsequence, or
     added to the second subsequence.

     Strategy:
     Use dynamic programming where each state represents the current GCD values
     of the two subsequences.

     For every number, transition each existing state in three ways:
     1. Skip the number.
     2. Add it to the first subsequence.
     3. Add it to the second subsequence.

     A GCD value of `0` represents an empty subsequence.

     Time Complexity:
     O(n * s), where `s` is the number of distinct GCD-state pairs.

     Space Complexity:
     O(s) for the dynamic-programming states.
     */
    func subsequencePairCount(_ nums: [Int]) -> Int {
        let modulo = 1_000_000_007

        // Keeping this helper close to its usage makes the transition logic
        // easier to follow without exposing an unrelated class-level method.
        func greatestCommonDivisor(_ firstNumber: Int, _ secondNumber: Int) -> Int {
            var dividend = firstNumber
            var divisor = secondNumber

            while divisor != 0 {
                let remainder = dividend % divisor
                dividend = divisor
                divisor = remainder
            }

            return dividend
        }

        // Initially, both subsequences are empty.
        var stateCounts: [GCDState: Int] = [
            GCDState(firstGCD: 0, secondGCD: 0): 1
        ]

        for number in nums {
            // Existing states represent the choice to skip the current number.
            var updatedStateCounts = stateCounts

            for (state, count) in stateCounts {
                // Add the current number to the first subsequence.
                let updatedFirstState = GCDState(
                    firstGCD: greatestCommonDivisor(state.firstGCD, number),
                    secondGCD: state.secondGCD
                )

                updatedStateCounts[updatedFirstState, default: 0] =
                    (updatedStateCounts[updatedFirstState, default: 0] + count) % modulo

                // Add the current number to the second subsequence.
                let updatedSecondState = GCDState(
                    firstGCD: state.firstGCD,
                    secondGCD: greatestCommonDivisor(state.secondGCD, number)
                )

                updatedStateCounts[updatedSecondState, default: 0] =
                    (updatedStateCounts[updatedSecondState, default: 0] + count) % modulo
            }

            stateCounts = updatedStateCounts
        }

        var validPairCount = 0

        for (state, count) in stateCounts {
            // A non-zero GCD confirms that both subsequences are non-empty.
            if state.firstGCD != 0 && state.firstGCD == state.secondGCD {
                validPairCount = (validPairCount + count) % modulo
            }
        }

        return validPairCount
    }
}

private struct GCDState: Hashable {
    let firstGCD: Int
    let secondGCD: Int
}
class Solution {
    private let modulo = 1_000_000_007

    /**
     Problem Summary:
     Count the number of valid zigzag arrays of length `n`, where each value is in `[l, r]`.
     A zigzag array must alternate between increasing and decreasing comparisons.

     Strategy:
     Model each state as:
     - `value` with the next move expected to go up
     - `value` with the next move expected to go down

     Build a transition matrix between these states, then use fast matrix exponentiation
     to apply `n - 1` transitions efficiently.

     Time Complexity:
     O((2m)^3 * log n), where `m = r - l + 1`

     Space Complexity:
     O((2m)^2)
     */
    func zigZagArrays(_ n: Int, _ l: Int, _ r: Int) -> Int {
        let valueCount = r - l + 1

        if n == 1 {
            return valueCount % modulo
        }

        let stateCount = 2 * valueCount
        let transitionMatrix = buildTransitionMatrix(valueCount: valueCount)

        // Every value can be the first element, with either direction state available.
        var stateVector = Array(repeating: Array(repeating: 1, count: stateCount), count: 1)

        applyPowerMultiplication(
            base: transitionMatrix,
            exponent: n - 1,
            result: &stateVector
        )

        return stateVector[0].reduce(0) { ($0 + $1) % modulo }
    }

    private func buildTransitionMatrix(valueCount: Int) -> [[Int]] {
        let stateCount = 2 * valueCount
        var matrix = Array(repeating: Array(repeating: 0, count: stateCount), count: stateCount)

        for currentValue in 0..<valueCount {
            // Previous move was down, so next value must be smaller.
            for nextValue in 0..<currentValue {
                matrix[currentValue][nextValue + valueCount] = 1
            }

            // Previous move was up, so next value must be larger.
            for nextValue in (currentValue + 1)..<valueCount {
                matrix[currentValue + valueCount][nextValue] = 1
            }
        }

        return matrix
    }

    private func multiply(_ leftMatrix: [[Int]], _ rightMatrix: [[Int]]) -> [[Int]] {
        let rowCount = leftMatrix.count
        let sharedCount = rightMatrix.count
        let columnCount = rightMatrix[0].count

        var product = Array(
            repeating: Array(repeating: 0, count: columnCount),
            count: rowCount
        )

        for row in 0..<rowCount {
            for sharedIndex in 0..<sharedCount {
                let leftValue = leftMatrix[row][sharedIndex]

                // Skip zero entries to avoid unnecessary work.
                guard leftValue != 0 else { continue }

                for column in 0..<columnCount {
                    product[row][column] = (
                        product[row][column] + leftValue * rightMatrix[sharedIndex][column]
                    ) % modulo
                }
            }
        }

        return product
    }

    private func applyPowerMultiplication(base: [[Int]], exponent: Int, result: inout [[Int]]) {
        var currentPower = base
        var remainingExponent = exponent

        while remainingExponent > 0 {
            // If this bit is set, apply the current transition power.
            if remainingExponent & 1 == 1 {
                result = multiply(result, currentPower)
            }

            // Square the transition matrix for the next bit.
            currentPower = multiply(currentPower, currentPower)
            remainingExponent /= 2
        }
    }
}
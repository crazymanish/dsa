class Solution {
    /**
     Problem Summary:
     Count the number of length `n` arrays where every value is in `[l, r]`
     and adjacent comparisons strictly alternate between increasing and decreasing.

     Strategy:
     Use dynamic programming by ending value and last movement direction.
     - `up[value]` counts arrays ending at `value` where the last move was upward.
     - `down[value]` counts arrays ending at `value` where the last move was downward.
     Prefix sums allow each transition to be computed in O(1).

     Time Complexity: O(n * m), where `m = r - l + 1`
     Space Complexity: O(m)
     */
    func zigZagArrays(_ n: Int, _ l: Int, _ r: Int) -> Int {
        let modulo = 1_000_000_007
        let valueCount = r - l + 1

        if n == 1 { return valueCount % modulo }
        if n == 2 { return valueCount * (valueCount - 1) % modulo }

        var endingWithUpMove = Array(repeating: 0, count: valueCount + 1)
        var endingWithDownMove = Array(repeating: 0, count: valueCount + 1)

        // Base case for arrays of length 2.
        // For each ending value:
        // - Up move means previous value was smaller.
        // - Down move means previous value was larger.
        for value in 1...valueCount {
            endingWithUpMove[value] = value - 1
            endingWithDownMove[value] = valueCount - value
        }

        for _ in 3...n {
            let upPrefixSum = buildPrefixSum(endingWithUpMove, modulo)
            let downPrefixSum = buildPrefixSum(endingWithDownMove, modulo)

            var nextEndingWithUpMove = Array(repeating: 0, count: valueCount + 1)
            var nextEndingWithDownMove = Array(repeating: 0, count: valueCount + 1)

            for value in 1...valueCount {
                // To end with an up move, previous value must be smaller
                // and previous movement must have been down.
                nextEndingWithUpMove[value] = downPrefixSum[value - 1]

                // To end with a down move, previous value must be larger
                // and previous movement must have been up.
                nextEndingWithDownMove[value] = (
                    upPrefixSum[valueCount] - upPrefixSum[value] + modulo
                ) % modulo
            }

            endingWithUpMove = nextEndingWithUpMove
            endingWithDownMove = nextEndingWithDownMove
        }

        var totalArrays = 0

        for value in 1...valueCount {
            totalArrays = (totalArrays + endingWithUpMove[value]) % modulo
            totalArrays = (totalArrays + endingWithDownMove[value]) % modulo
        }

        return totalArrays
    }

    private func buildPrefixSum(_ values: [Int], _ modulo: Int) -> [Int] {
        var prefixSum = values

        for index in 1..<prefixSum.count {
            prefixSum[index] = (prefixSum[index] + prefixSum[index - 1]) % modulo
        }

        return prefixSum
    }
}
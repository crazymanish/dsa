class Solution {

    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(n), where n = nums.count
    ///     Single pass over the array plus a final scan.
    ///
    /// Space Complexity:
    ///   • O(n)
    ///     Uses two auxiliary arrays to track partial sums and phase states.
    ///
    /// Problem Summary:
    ///   Find the maximum sum of a subarray that follows a *trionic pattern*:
    ///
    ///       strictly increasing → strictly decreasing → strictly increasing
    ///
    ///   Each phase must appear at least once.
    ///
    /// Note:
    ///   This solution encodes the three phases implicitly using counters
    ///   and dynamic accumulation of partial sums.
    /// -----------------------------------------------------------------------
    func maxSumTrionic(_ nums: [Int]) -> Int {
        let length = nums.count
        guard length >= 3 else { return Int.min }

        // accumulatedSum[i]: best trionic sum ending at index i
        var accumulatedSum = Array(repeating: 0, count: length)

        // phaseCount[i]:
        //   0 = invalid
        //   1 = increasing phase started
        //   2 = decreasing phase reached
        //   3 = final increasing phase reached (valid trionic)
        var phaseCount = Array(repeating: 0, count: length)

        // Running sum for the current increasing segment
        var increasingRunSum = nums[0]

        // Index where the current candidate trionic subarray starts
        var peakIndex = 0

        // Index of the last completed peak
        var lastPeakIndex = -1

        // Accumulator used while transitioning from decreasing → increasing
        var transitionAccumulator = 0

        // Indicates whether we just entered a new decreasing phase
        var needsInitialExtension = true

        for index in 1..<length {
            let previous = nums[index - 1]
            let current = nums[index]

            if current > previous {
                // -------------------------
                // Increasing phase
                // -------------------------

                accumulatedSum[index] = increasingRunSum + current

                // Extend or restart increasing run
                increasingRunSum = current + max(0, increasingRunSum)
                peakIndex = index
                phaseCount[index] = 1

                // Handle continuation after a decreasing phase
                if lastPeakIndex != -1 {
                    if needsInitialExtension {
                        accumulatedSum[lastPeakIndex] += current
                        needsInitialExtension = false
                    } else {
                        if transitionAccumulator + current > 0 {
                            accumulatedSum[lastPeakIndex] += transitionAccumulator + current
                            transitionAccumulator = 0
                        } else {
                            transitionAccumulator += current
                        }
                    }

                    phaseCount[lastPeakIndex] =
                        phaseCount[lastPeakIndex] >= 2 ? 3 : 0
                }

            } else if current < previous {
                // -------------------------
                // Decreasing phase
                // -------------------------

                increasingRunSum = current
                accumulatedSum[peakIndex] += current

                // Mark that we reached decreasing phase
                phaseCount[peakIndex] =
                    phaseCount[peakIndex] > 0 ? 2 : 0

                lastPeakIndex = peakIndex
                transitionAccumulator = 0
                needsInitialExtension = true

            } else {
                // -------------------------
                // Equal values break all phases
                // -------------------------

                increasingRunSum = current
                peakIndex = index
                lastPeakIndex = -1
                transitionAccumulator = 0
                needsInitialExtension = true
            }
        }

        // Extract the maximum sum among valid trionic subarrays
        var bestSum = Int.min
        for index in 0..<length {
            if phaseCount[index] == 3 {
                bestSum = max(bestSum, accumulatedSum[index])
            }
        }

        return bestSum
    }
}

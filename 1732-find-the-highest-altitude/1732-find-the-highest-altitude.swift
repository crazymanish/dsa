/**
 * Problem Summary:
 * Given an array `gain` where `gain[i]` represents the net altitude change
 * between points, return the highest altitude reached. The trip starts at altitude 0.
 *
 * Strategy:
 * - Maintain a running prefix sum representing the current altitude.
 * - Track the maximum altitude seen during traversal.
 * - Since the starting altitude is 0, initialize the answer to 0.
 *
 * Time Complexity:
 * O(n)
 *
 * Space Complexity:
 * O(1)
 */
class Solution {
    func largestAltitude(_ gain: [Int]) -> Int {
        var currentAltitude = 0
        var highestAltitude = 0

        // Build altitudes incrementally and track the maximum reached.
        for altitudeGain in gain {
            currentAltitude += altitudeGain
            highestAltitude = max(highestAltitude, currentAltitude)
        }

        return highestAltitude
    }
}
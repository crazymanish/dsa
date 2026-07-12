/**
 Problem Summary:
 Given an integer array, replace each element with its rank when the array is sorted.
 Equal values receive the same rank, and ranks start from 1.

 Strategy:
 1. Create a sorted copy of the array.
 2. Assign a rank to each unique value while traversing the sorted array.
 3. Replace each original value with its assigned rank.

 Time Complexity:
 O(n log n)
 - Sorting dominates the runtime.

 Space Complexity:
 O(n)
 - Hash map for value-to-rank mapping.
 */
class Solution {
    func arrayRankTransform(_ array: [Int]) -> [Int] {
        // Sort the values to determine their ranking order.
        let sortedArray = array.sorted()

        // Maps each unique value to its assigned rank.
        var valueToRank: [Int: Int] = [:]
        var nextRank = 1

        // Assign ranks only to unique values.
        for value in sortedArray where valueToRank[value] == nil {
            valueToRank[value] = nextRank
            nextRank += 1
        }

        // Replace each original value with its corresponding rank.
        return array.map { valueToRank[$0]! }
    }
}
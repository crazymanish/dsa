/**
 Problem Summary:
 Given an integer array `nums` and an integer `limit`, you may swap two
 elements if the absolute difference between their values is at most `limit`.

 Return the lexicographically smallest array obtainable after any number
 of valid swaps.

 Strategy:
 1. Sort all values in ascending order.
 2. Divide the sorted values into groups:
    - Consecutive values belong to the same group when their difference
      is at most `limit`.
    - Otherwise, a new group begins.
 3. Values within the same group can effectively be rearranged among all
    positions that originally contained values from that group.
 4. Traverse the original array from left to right and replace each value
    with the smallest unused value from its corresponding group.
 5. Because each group is already sorted, consuming values from left to
    right produces the lexicographically smallest possible array.

 Time Complexity:
 O(n log n), primarily due to sorting.

 Space Complexity:
 O(n) for the groups, value-to-group mapping, and result array.
 */
class Solution {
    func lexicographicallySmallestArray(_ nums: [Int], _ limit: Int) -> [Int] {
        let sortedNums = nums.sorted()

        // Maps each value to the connected group it belongs to.
        var valueToGroup: [Int: Int] = [:]

        var currentGroup = 0
        valueToGroup[sortedNums[0]] = currentGroup

        // Since values are processed in sorted order, every group is
        // automatically stored in ascending order.
        var groups: [[Int]] = [[sortedNums[0]]]

        // Build groups of values connected through differences <= limit.
        for index in 1..<sortedNums.count {
            let currentValue = sortedNums[index]
            let previousValue = sortedNums[index - 1]

            // A gap larger than `limit` means values on opposite sides
            // cannot be connected through valid swaps.
            if currentValue - previousValue > limit {
                currentGroup += 1
                groups.append([])
            }

            valueToGroup[currentValue] = currentGroup
            groups[currentGroup].append(currentValue)
        }

        // Tracks the next smallest unused value in each group.
        var nextIndexInGroup = Array(repeating: 0, count: groups.count)
        var result = nums

        // Fill positions from left to right with the smallest value
        // available from the position's corresponding group.
        for index in nums.indices {
            let originalValue = nums[index]
            let group = valueToGroup[originalValue]!
            let valueIndex = nextIndexInGroup[group]

            result[index] = groups[group][valueIndex]
            nextIndexInGroup[group] += 1
        }

        return result
    }
}
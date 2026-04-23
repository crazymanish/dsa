class Solution {
    /**
     Problem Summary:
     For each index `i`, compute the total distance to all other indices `j`
     where nums[i] == nums[j].

     Strategy:
     - Use two passes:
       1. Left → Right (prefix)
       2. Right → Left (suffix)
     - Track:
       count of occurrences
       sum of indices
     - Use math to avoid nested loops.

     Time Complexity: O(n)
     Space Complexity: O(n)
     */
    func distance(_ nums: [Int]) -> [Int] {
        let n = nums.count
        var distances = Array(repeating: 0, count: n)

        // Prefix (left side tracking)
        var leftCount: [Int: Int] = [:]      // value → frequency so far
        var leftIndexSum: [Int: Int] = [:]   // value → sum of indices so far

        // Suffix (right side tracking)
        var rightCount: [Int: Int] = [:]
        var rightIndexSum: [Int: Int] = [:]

        // -------- Left to Right Pass --------
        for index in 0..<n {
            let value = nums[index]

            // Update prefix frequency and index sum for current value
            leftCount[value, default: 0] += 1
            leftIndexSum[value, default: 0] += index

            // Distance contribution from all previous same values
            // Formula: (count * currentIndex) - sumOfPreviousIndices
            let occurrenceCount = leftCount[value, default: 0]
            let indicesSum = leftIndexSum[value, default: 0]

            distances[index] = occurrenceCount * index - indicesSum
        }

        // -------- Right to Left Pass --------
        for index in stride(from: n - 1, through: 0, by: -1) {
            let value = nums[index]

            // Update suffix frequency and index sum
            rightCount[value, default: 0] += 1
            rightIndexSum[value, default: 0] += index

            // Distance contribution from all future same values
            // Formula: sumOfNextIndices - (count * currentIndex)
            let occurrenceCount = rightCount[value, default: 0]
            let indicesSum = rightIndexSum[value, default: 0]

            distances[index] += indicesSum - occurrenceCount * index
        }

        return distances
    }
}
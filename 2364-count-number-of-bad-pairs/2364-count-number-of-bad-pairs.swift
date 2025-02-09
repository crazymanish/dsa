class Solution {
    func countBadPairs(_ nums: [Int]) -> Int {
        // Dictionary to store the count of each arithmetic series (nums[i] - i).
        var seriesCounts: [Int: Int] = [:]

        // Iterate through the input array and count the occurrences of each series.
        for i in 0..<nums.count {
            let series = nums[i] - i  // Calculate the arithmetic series value.
            seriesCounts[series, default: 0] += 1 // Increment the count for this series.
        }

        // Calculate the total number of possible pairs.
        let totalPairs = nums.count * (nums.count - 1) / 2

        // Calculate the number of "good" pairs (pairs belonging to the same series).
        let goodPairs = seriesCounts.values.reduce(0) { sum, count in
            // For each series with more than one element, calculate the number of good pairs within it.
            if count > 1 {
                return sum + count * (count - 1) / 2
            } else {
                return sum
            }
        }

        // The number of "bad" pairs is the total number of pairs minus the number of "good" pairs.
        return totalPairs - goodPairs
    }
}
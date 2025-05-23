class Solution {
    // Time Complexity: O(N log N)
    // Space Complexity: O(N)
    func maximumValueSum(_ nums: [Int], _ k: Int, _ edges: [[Int]]) -> Int {
        // Calculate the change in value if a number is XORed with k.
        // This 'delta' represents how much the original number's value
        // would increase or decrease if we apply the XOR operation to it.
        // Time: O(N) for map
        // Space: O(N) for `valueChanges` array
        var valueChanges: [Int] = nums.map { ($0 ^ k) - $0 }

        // Sort these value changes in descending order.
        // This is crucial for the greedy approach: we want to prioritize applying
        // the XOR operation to pairs of numbers that yield the largest positive sum of changes.
        // Time: O(N log N)
        valueChanges.sort(by: >)

        // Initialize the total sum with the sum of all original numbers.
        // We will then add the positive 'valueChanges' to this sum.
        // Time: O(N) for reduce
        var totalValueSum = nums.reduce(0, +)

        // Iterate through the sorted 'valueChanges' array in pairs.
        // The problem implies that if we apply the XOR operation to a node,
        // we must apply it to an adjacent node as well. This effectively means
        // operations are applied in pairs. We want to find the largest positive
        // changes from such pairs.
        // Time: O(N) as it iterates through `valueChanges` once.
        for i in stride(from: 0, to: valueChanges.count, by: 2) {
            // Ensure we have a pair to process. If 'i' is the last index, we don't have a pair.
            if i == valueChanges.count - 1 {
                break
            }

            // Calculate the sum of value changes for the current pair.
            let currentPairDeltaSum = valueChanges[i] + valueChanges[i + 1]

            // If the sum of changes for this pair is positive, it means applying
            // the XOR operation to these two numbers increases the total sum.
            if currentPairDeltaSum > 0 {
                totalValueSum += currentPairDeltaSum // Add this positive change to the total sum.
            } else {
                // If the sum of changes for this pair is zero or negative,
                // then adding any further pairs (which will have even smaller or more negative deltas
                // because the array is sorted descendingly) will not increase the total sum.
                // So, we can stop here.
                break
            }
        }

        return totalValueSum // Return the maximum possible total value sum.
    }
}
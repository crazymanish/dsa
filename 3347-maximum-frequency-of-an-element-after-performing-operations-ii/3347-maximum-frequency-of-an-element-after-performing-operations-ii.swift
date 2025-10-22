/// # Time Complexity:
/// O(n log n)
/// - Sorting the array takes O(n log n)
/// - For each of the 3n target values, binary search operations take O(log n) each
/// - Overall: O(n log n)
///
/// # Space Complexity:
/// O(n)
/// - Storing the sorted array and frequency dictionary each require O(n)
/// - The intermediate array from `flatMap` creates up to 3n elements, which is O(n)
///
class Solution {
    /// Finds the maximum possible frequency of any number in the array
    /// after performing up to `numOperations`, where each operation
    /// can increase or decrease an element by at most `k`.
    ///
    /// - Parameters:
    ///   - nums: The input array of integers.
    ///   - k: The allowed change per operation (±k).
    ///   - numOperations: The number of allowed operations.
    /// - Returns: The maximum frequency achievable.
    func maxFrequency(_ nums: [Int], _ k: Int, _ numOperations: Int) -> Int {
        nums
            .flatMap {
                // For each element, consider three potential target values:
                // - element - k (if we decrease it)
                // - element (no change)
                // - element + k (if we increase it)
                [$0 - k, $0, $0 + k]
            }
            .map { [sortedNums = nums.sorted(),
                    frequencies = nums.grouped(by: \.self).mapValues(\.count)] target in
                // For each possible target value:
                min(
                    // 1️⃣ Compute how many elements in sortedNums fall within [target - k, target + k].
                    //    Using binary search (via partitioningIndex) to find range bounds efficiently.
                    sortedNums.partitioningIndex { $0 > target + k }
                    - sortedNums.partitioningIndex { $0 >= target - k },

                    // 2️⃣ Add available operations to increase frequency
                    //    (limited by numOperations) plus existing frequency of target.
                    frequencies[target, default: 0] + numOperations
                )
            }
            // Return the highest possible frequency found.
            .max() ?? 0
    }
}

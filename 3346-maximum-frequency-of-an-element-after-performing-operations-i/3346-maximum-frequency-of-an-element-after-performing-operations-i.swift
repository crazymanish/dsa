// Time Complexity: O(N log N)
// Let N be the number of elements in `nums`.
// 1. Sorting `nums` takes O(N log N) time.
// 2. Building `initialFreqMap` takes O(N) time.
// 3. Building the `candidateTargets` set takes O(N) time. Let M be the size
//    of the set, M <= 3*N.
// 4. Sorting `candidateTargets` takes O(M log M) = O(N log N) time.
// 5. The main loop iterates M times (O(N) iterations).
// 6. Inside the loop, we call `findLowerBound` twice, which is a binary
//    search, taking O(log N) time each.
// 7. The total time for the loop is O(M * log N) = O(N log N).
// The dominant factor is O(N log N), so the total time complexity is O(N log N).

// Space Complexity: O(N)
// `sortedNums`, `initialFreqMap`, `candidateTargets`, and `sortedCandidates`
// all take space proportional to N.

class Solution {
    /// Finds the maximum number of elements that can be made equal to a single value.
    ///
    /// We can pick any element `nums[i]` and change it to any value in the
    /// inclusive range `[nums[i] - k, nums[i] + k]`.
    /// We can perform this operation at most `numOperations` times.
    ///
    /// - Parameters:
    ///   - nums: The input array of numbers.
    ///   - k: The allowed range for transformation.
    ///   - numOperations: The maximum number of transformations (our "budget").
    /// - Returns: The maximum frequency of a single value achievable.
    func maxFrequency(_ nums: [Int], _ k: Int, _ numOperations: Int) -> Int {
        // Sort the array to enable efficient binary search for ranges.
        let sortedNums = nums.sorted()
        let n = sortedNums.count
        
        var maxAchievableFreq = 0
        
        // Pre-calculate the frequency of each number.
        var initialFreqMap: [Int: Int] = [:]
        for num in sortedNums {
            initialFreqMap[num, default: 0] += 1
        }
        
        // --- 1. Identify all potential optimal target values ---
        var candidateTargets = Set<Int>()
        for num in sortedNums {
            candidateTargets.insert(num)
            candidateTargets.insert(num - k)
            candidateTargets.insert(num + k)
        }
        
        let sortedCandidates = candidateTargets.sorted()
        
        // --- Helper Function: Binary Search (Lower Bound) ---
        /// Finds the first index `i` in `sortedNums` such that `sortedNums[i] >= targetValue`.
        /// This is a standard "lower bound" binary search.
        func findLowerBound(for targetValue: Int) -> Int {
            var left = 0
            var right = n // `n` is the non-inclusive upper bound
            
            while left < right {
                let mid = (left + right) / 2
                if sortedNums[mid] < targetValue {
                    // Element is too small, so the bound must be at or after mid + 1.
                    left = mid + 1
                } else {
                    // Element is >= targetValue. This *could* be the bound.
                    // We search the left half, *including* mid.
                    right = mid
                }
            }
            // When the loop ends, left == right, and this is the lower bound.
            return left
        }
        
        // --- 2. Check each candidate target value ---
        for target in sortedCandidates {
            // We need to find all `num` in the range `[target - k, target + k]`.
            let minRange = target - k
            let maxRange = target + k
            
            // --- Binary Search for the range [minRange, maxRange] ---
            
            // Find `leftIdx`: the index of the first element >= minRange.
            let leftIdx = findLowerBound(for: minRange)
            
            // Find `rightIdx`: the index of the first element > maxRange.
            // This is equivalent to finding the lower bound for `maxRange + 1`.
            let rightIdx = findLowerBound(for: maxRange + 1)
            
            // --- 3. Calculate frequency for this target ---
            
            // Total number of elements in `nums` that *can* be transformed to `target`.
            let transformableCount = rightIdx - leftIdx
            
            // Number of elements that are *already* equal to `target`.
            let alreadyEqualCount = initialFreqMap[target, default: 0]
            
            // Number of elements that *can* be transformed but *are not* `target`.
            let needOperationCount = transformableCount - alreadyEqualCount
            
            // We can use at most `numOperations` on the elements that need it.
            let operationsToUse = min(needOperationCount, numOperations)
            
            // The total frequency for this `target` is the sum of:
            // 1. Elements already equal (cost 0)
            // 2. Elements we can *afford* to transform (cost 1)
            let currentTargetFreq = alreadyEqualCount + operationsToUse
            
            maxAchievableFreq = max(maxAchievableFreq, currentTargetFreq)
        }
        
        return maxAchievableFreq
    }
}
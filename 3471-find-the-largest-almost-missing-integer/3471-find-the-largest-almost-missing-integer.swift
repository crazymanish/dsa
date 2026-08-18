class Solution {
    /**
     Problem Summary:
     Find the largest integer that appears in exactly one subarray of length `k`.

     Strategy:
     - Maintain a frequency map for the current sliding window.
     - For every window, count each distinct value in that window exactly once.
     - Slide the window by removing the outgoing value and adding the incoming value.
     - Finally, return the largest value that appeared in exactly one window.

     Time Complexity:
     O((n - k + 1) * d), where `d` is the number of distinct values in a window.
     In the worst case, O(n * k).

     Space Complexity:
     O(n) for the frequency maps.
     */
    func largestInteger(_ nums: [Int], _ k: Int) -> Int {
        var windowAppearances: [Int: Int] = [:]
        var windowFrequency: [Int: Int] = [:]

        // Build the first window.
        for index in 0..<k {
            windowFrequency[nums[index], default: 0] += 1
        }

        let lastWindowStart = nums.count - k

        for windowStart in 0...lastWindowStart {
            // Each distinct number in this window should be counted only once,
            // regardless of how many times it occurs inside the window.
            for number in windowFrequency.keys {
                windowAppearances[number, default: 0] += 1
            }

            // No need to slide after processing the final window.
            guard windowStart < lastWindowStart else { break }

            let outgoingNumber = nums[windowStart]
            let incomingNumber = nums[windowStart + k]

            // Remove the element leaving the sliding window.
            if windowFrequency[outgoingNumber] == 1 {
                windowFrequency[outgoingNumber] = nil
            } else {
                windowFrequency[outgoingNumber]! -= 1
            }

            // Add the new element entering the sliding window.
            windowFrequency[incomingNumber, default: 0] += 1
        }

        // Find the largest number that appeared in exactly one window.
        var largestUniqueNumber = -1

        for (number, appearanceCount) in windowAppearances {
            if appearanceCount == 1 {
                largestUniqueNumber = max(largestUniqueNumber, number)
            }
        }

        return largestUniqueNumber
    }
}
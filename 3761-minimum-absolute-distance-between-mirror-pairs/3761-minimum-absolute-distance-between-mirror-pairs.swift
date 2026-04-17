class Solution {
    /**
     Problem Summary:
     Given an array of integers, find the minimum distance between two indices (i, j)
     such that nums[i] is the reverse of nums[j] (mirror pair).
     Return the minimum index distance, or -1 if no such pair exists.

     Strategy:
     - Traverse the array once.
     - Maintain a dictionary that maps a number's reversed value to its latest index.
     - For each number:
        1. Check if it exists in the map → meaning we’ve already seen its reversed pair.
        2. If yes, compute distance and update the minimum.
        3. Store the reversed value of the current number for future matches.
     - This ensures we always match with the closest previous occurrence.

     Time Complexity:
     O(n * d)
     - n = number of elements
     - d = number of digits per number (for reversing)

     Space Complexity:
     O(n)
     - For storing reversed values in the dictionary
     */
    func minMirrorPairDistance(_ nums: [Int]) -> Int {
        // Helper function to reverse digits of a number
        func reverseNumber(_ value: Int) -> Int {
            var number = value
            var reversedValue = 0

            while number > 0 {
                reversedValue = reversedValue * 10 + number % 10
                number /= 10
            }

            return reversedValue
        }

        let totalCount = nums.count
        guard totalCount > 1 else { return -1 }

        // Stores: reversedNumber -> latest index where it appeared
        var reversedIndexMap: [Int: Int] = [:]

        var minimumDistance = Int.max

        for (currentIndex, currentValue) in nums.enumerated() {
            // If current value matches a previously stored reversed number,
            // we found a mirror pair
            if let previousIndex = reversedIndexMap[currentValue] {
                let distance = currentIndex - previousIndex
                minimumDistance = min(minimumDistance, distance)
            }

            // Store the reversed version of the current value
            // so future elements can match against it
            let reversedValue = reverseNumber(currentValue)
            reversedIndexMap[reversedValue] = currentIndex
        }

        return minimumDistance == Int.max ? -1 : minimumDistance
    }
}
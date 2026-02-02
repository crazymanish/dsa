final class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(n log d)
    ///     - n = nums.count
    ///     - d = dist
    ///     Each step performs binary search insert/remove in a sorted window.
    ///
    /// Space Complexity:
    ///   • O(d)
    ///     - Maintains a sorted sliding window of size (dist + 1).
    ///
    /// Problem Summary:
    ///   We must choose:
    ///     - nums[0] (always included)
    ///     - (k0 - 1) additional elements
    ///   such that:
    ///     - Their indices differ by at most `dist`
    ///     - The total sum is minimized
    ///
    /// Strategy:
    ///   - Fix nums[0]
    ///   - Use a sliding window of size (dist + 1)
    ///   - Always keep the smallest (k0 - 1) elements in the window
    ///   - Track their sum efficiently
    /// -----------------------------------------------------------------------
    func minimumCost(_ nums: [Int], _ k0: Int, _ dist: Int) -> Int {
        let n = nums.count
        let requiredCount = k0 - 1   // how many elements we need besides nums[0]
        
        // Sorted window holding candidates within the current distance
        var sortedWindow = [Int]()
        sortedWindow.reserveCapacity(dist + 2)
        
        /// Inserts an element into the sorted window
        func insertSorted(_ value: Int) {
            let index = sortedWindow.binarySearchInsert(value)
            sortedWindow.insert(value, at: index)
        }
        
        /// Removes an element from the sorted window
        func removeSorted(_ value: Int) {
            let index = sortedWindow.binarySearchLeft(value)
            sortedWindow.remove(at: index)
        }
        
        // Initialize the first window: indices [1 ... dist + 1]
        for index in 1...dist + 1 {
            insertSorted(nums[index])
        }
        
        // Sum of the smallest `requiredCount` elements
        var currentSum = sortedWindow.prefix(requiredCount).reduce(0, +)
        var minimumWindowSum = currentSum
        
        // Slide the window forward
        if dist + 2 < n {
            for rightIndex in (dist + 2)..<n {
                let enteringValue = nums[rightIndex]
                let leavingValue = nums[rightIndex - dist - 1]
                
                // Handle insertion
                if enteringValue < sortedWindow[requiredCount - 1] {
                    currentSum += enteringValue
                    currentSum -= sortedWindow[requiredCount - 1]
                }
                insertSorted(enteringValue)
                
                // Handle removal
                let removeIndex = sortedWindow.binarySearchLeft(leavingValue)
                if removeIndex < requiredCount {
                    currentSum -= leavingValue
                    currentSum += sortedWindow[requiredCount]
                }
                removeSorted(leavingValue)
                
                minimumWindowSum = min(minimumWindowSum, currentSum)
            }
        }
        
        // nums[0] must always be included
        return nums[0] + minimumWindowSum
    }
}

extension Array where Element == Int {
    /// Returns the leftmost index where `value` should be inserted
    /// to maintain sorted order.
    func binarySearchLeft(_ value: Int) -> Int {
        var left = 0, right = count
        while left < right {
            let mid = (left + right) >> 1
            if self[mid] < value {
                left = mid + 1
            } else {
                right = mid
            }
        }
        return left
    }

    /// Returns the insertion index such that elements <= value
    /// remain on the left (upper bound).
    func binarySearchInsert(_ value: Int) -> Int {
        var left = 0, right = count
        while left < right {
            let mid = (left + right) >> 1
            if self[mid] <= value {
                left = mid + 1
            } else {
                right = mid
            }
        }
        return left
    }
}

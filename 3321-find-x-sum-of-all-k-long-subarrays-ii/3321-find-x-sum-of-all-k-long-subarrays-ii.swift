// MARK: - Complexity Analysis
//
// Time Complexity: O(n * log k)
//   - Each insertion/removal/balance uses binary search (log k) and array shifts (amortized small).
//   - Overall O(n log k) across the array.
//
// Space Complexity: O(k)
//   - We track frequencies and store at most k elements in the current window.

final class Solution {
    // MARK: - Utility for comparing and ordering (freq, num) pairs
    @inline(__always)
    private func less(_ a: (Int, Int), _ b: (Int, Int)) -> Bool {
        // Order by frequency first, then by number
        if a.0 != b.0 { return a.0 < b.0 }
        return a.1 < b.1
    }

    // Binary search: find first index where !(arr[idx] < key)
    private func lowerBound(_ arr: [(Int, Int)], _ key: (Int, Int)) -> Int {
        var l = 0, r = arr.count
        while l < r {
            let m = (l + r) >> 1
            if less(arr[m], key) { l = m + 1 }
            else { r = m }
        }
        return l
    }

    // Binary search: find first index where key < arr[idx]
    private func upperBound(_ arr: [(Int, Int)], _ key: (Int, Int)) -> Int {
        var l = 0, r = arr.count
        while l < r {
            let m = (l + r) >> 1
            if less(key, arr[m]) { r = m }
            else { l = m + 1 }
        }
        return l
    }

    // Insert keeping the array sorted
    @discardableResult
    private func insertSorted(_ arr: inout [(Int, Int)], _ key: (Int, Int)) -> Int {
        let idx = upperBound(arr, key) // stable insert after equals
        arr.insert(key, at: idx)
        return idx
    }

    // Remove one occurrence equal to `key` if exists
    @discardableResult
    private func removeOneEqual(_ arr: inout [(Int, Int)], _ key: (Int, Int)) -> Int? {
        let idx = lowerBound(arr, key)
        if idx < arr.count && arr[idx] == key {
            arr.remove(at: idx)
            return idx
        }
        return nil
    }

    func findXSum(_ nums: [Int], _ k: Int, _ x: Int) -> [Int] {
        // Frequency dictionary for current window
        var freq: [Int: Int] = [:]
        // Two partitions:
        // top   → the x largest (freq, num) pairs (by ordering)
        // bottom → all other pairs
        var top = [(Int, Int)]()
        var bottom = [(Int, Int)]()

        // Running sum of freq * num for all elements in top
        var topSum = 0

        // Helper to get key for given num
        @inline(__always)
        func key(of num: Int) -> (Int, Int) { (freq[num] ?? 0, num) }

        // Move smallest element from top → bottom
        func moveTopSmallestToBottom() {
            guard let smallest = top.first else { return }
            top.removeFirst()
            topSum -= smallest.0 * smallest.1
            insertSorted(&bottom, smallest)
        }

        // Move largest element from bottom → top
        func moveBottomLargestToTop() {
            guard let largest = bottom.last else { return }
            bottom.removeLast()
            insertSorted(&top, largest)
            topSum += largest.0 * largest.1
        }

        // Maintain invariants:
        // 1) top.count <= x
        // 2) top contains the x largest keys
        func balance() {
            // If top has too many, move smallest ones down
            while top.count > x { moveTopSmallestToBottom() }
            // If top has too few, promote largest from bottom
            while top.count < x, !bottom.isEmpty { moveBottomLargestToTop() }

            // Ensure ordering invariant between top and bottom
            while !bottom.isEmpty, !top.isEmpty, less(top.first!, bottom.last!) {
                // Swap smallest of top with largest of bottom
                let bot = bottom.removeLast()
                let topSmall = top.removeFirst()

                // Update topSum: remove old topSmall, add new bot
                topSum = topSum - topSmall.0 * topSmall.1 + bot.0 * bot.1

                // Reinsert swapped items to keep sorted order
                insertSorted(&top, bot)
                insertSorted(&bottom, topSmall)
            }
        }

        // Add a number to the window
        func addNum(_ num: Int) {
            let oldFreq = freq[num] ?? 0
            if oldFreq > 0 {
                let oldKey = (oldFreq, num)
                if removeOneEqual(&top, oldKey) != nil {
                    // Case 1: Number was in top
                    topSum -= oldKey.0 * oldKey.1
                    let newF = oldFreq + 1
                    freq[num] = newF
                    let newKey = (newF, num)
                    insertSorted(&top, newKey)
                    topSum += newKey.0 * newKey.1
                } else {
                    // Case 2: Number was in bottom
                    _ = removeOneEqual(&bottom, oldKey)
                    let newF = oldFreq + 1
                    freq[num] = newF
                    let newKey = (newF, num)
                    insertSorted(&bottom, newKey)
                }
            } else {
                // Case 3: First appearance of num → goes to bottom
                freq[num] = 1
                insertSorted(&bottom, (1, num))
            }
            balance()
        }

        // Remove a number leaving the window
        func removeNum(_ num: Int) {
            guard let oldF = freq[num] else { return }
            let oldKey = (oldF, num)

            if removeOneEqual(&top, oldKey) != nil {
                // Case 1: It was in top
                topSum -= oldKey.0 * oldKey.1
                let newF = oldF - 1
                if newF == 0 {
                    freq.removeValue(forKey: num)
                } else {
                    freq[num] = newF
                    let newKey = (newF, num)
                    insertSorted(&top, newKey)
                    topSum += newKey.0 * newKey.1
                }
            } else {
                // Case 2: It was in bottom
                _ = removeOneEqual(&bottom, oldKey)
                let newF = oldF - 1
                if newF == 0 {
                    freq.removeValue(forKey: num)
                } else {
                    freq[num] = newF
                    let newKey = (newF, num)
                    insertSorted(&bottom, newKey)
                }
            }
            balance()
        }

        // MARK: - Sliding Window
        var ans = [Int]()

        for i in 0..<nums.count {
            // Add new element to the window
            addNum(nums[i])

            // Remove element that slides out
            if i >= k { removeNum(nums[i - k]) }

            // Once window has size k, record the sum of top elements
            if i >= k - 1 { ans.append(topSum) }
        }

        return ans
    }
}

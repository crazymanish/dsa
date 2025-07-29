// Time Complexity: O(N * K)
// The code iterates through the array once (O(N)). Inside the loop, the bit manipulation
// helpers and the inner while loop's work are bounded. The right pointer only moves
// from right to left once over the whole execution. Each number is processed by the bit
// counters a constant number of times. K is the number of bits in an integer (e.g., 32),
// so the complexity is effectively linear, O(N).
//
// Space Complexity: O(N)
// O(N) is required for the result array. O(K) is used for the bit counter array,
// which is constant space.

class Solution {
    func smallestSubarrays(_ nums: [Int]) -> [Int] {
        let n = nums.count
        var result = [Int](repeating: 0, count: n)
        
        // `bitCounts[i]` stores the count of numbers in our current window that have the i-th bit set.
        var bitCounts = [Int](repeating: 0, count: 32)
        
        // `rightPointer` tracks the right boundary of our sliding window [leftPointer...rightPointer].
        var rightPointer = n - 1

        /// Adds a number's bits to the window's total bit count.
        func add(_ num: Int) {
            for i in 0..<32 {
                if (num >> i) & 1 == 1 {
                    bitCounts[i] += 1
                }
            }
        }

        /// Tries to remove a number's bits from the window.
        /// - Returns: `true` if removal is "safe" (doesn't decrease the window's OR value), `false` otherwise.
        func tryToRemove(_ num: Int) -> Bool {
            // First, check if removing this number would cause any bit to disappear from the total OR.
            // This happens if a bit is set in `num` AND it's the *last* number in the window contributing that bit.
            for i in 0..<32 {
                if (num >> i) & 1 == 1 && bitCounts[i] == 1 {
                    return false // Removal is not safe.
                }
            }
            
            // If the check passes, it's safe to perform the removal.
            for i in 0..<32 {
                if (num >> i) & 1 == 1 {
                    bitCounts[i] -= 1
                }
            }
            return true
        }

        // Iterate with the left pointer from right to left.
        for leftPointer in (0..<n).reversed() {
            // 1. Expand the window to the left by including the current element.
            add(nums[leftPointer])
            
            // 2. Shrink the window from the right as much as possible, as long as
            //    the removal doesn't change the window's total bitwise OR value.
            while leftPointer < rightPointer && tryToRemove(nums[rightPointer]) {
                rightPointer -= 1
            }
            
            // 3. The current window [leftPointer...rightPointer] is now the smallest possible
            //    starting at `leftPointer` with the maximum OR value. Record its length.
            result[leftPointer] = rightPointer - leftPointer + 1
        }
        
        return result
    }
}
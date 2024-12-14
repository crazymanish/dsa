class Solution {
    func continuousSubarrays(_ nums: [Int]) -> Int {
        let n = nums.count

        // Use 2 pointers lo and hi (sliding window) and maintain the
        // counts of integers between the indices lo and hi included.
        var (lo, hi) = (0, 0)
        var counts = [nums[lo]: 1]

        var res = 0
        while hi < n {
            if counts.keys.max()! - counts.keys.min()! <= 2 {
                // nums[lo...hi] is continuous, so we add to the result all the continuous
                // arrays that end at hi.
                res += hi - lo + 1

                // Expand the window.
                hi += 1
                if hi < n { counts[nums[hi], default: 0] += 1 }
            } else {
                // nums[lo...hi] is not continuous.
                // Shrink the window.
                counts[nums[lo], default: 0] -= 1
                if counts[nums[lo]] == 0 { counts[nums[lo]] = nil }
                lo += 1
            }
        }
        return res
    }
}
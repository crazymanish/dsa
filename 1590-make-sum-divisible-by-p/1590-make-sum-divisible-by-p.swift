class Solution {
    func minSubarray(_ nums: [Int], _ p: Int) -> Int {
        // Calculate the total sum of the elements in the array.
        let total = nums.reduce(0) { $0 + $1 }
        
        // Calculate the remainder when the total sum is divided by p.
        let k = total % p
        
        // If the sum is already divisible by p, no removal is needed.
        if k == 0 {
            return 0
        }
        
        var sum = 0
        // Store cumulative sums and their indices.
        var remindersToIndexes: [Int: Int] = [0: -1]
        var res = nums.count

        for (index, num) in nums.enumerated() {
            sum += num
            let reminder = sum % p // Calculate the remainder of the current subarray sum.
            
            // Calculate the other remainder needed to make the sum divisible by p.
            var other = (reminder - k + p) % p
            
            if let prefix = remindersToIndexes[other] {
                // Update the result with the minimum subarray length.
                res = min(res, index - prefix)
            }

            // Store the current remainder and index.
            remindersToIndexes[reminder] = index
        }
        
        // Ensure that the entire array is not removed.
        return res < nums.count ? res : -1
    }
}
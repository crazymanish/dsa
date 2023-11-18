class Solution {
    func maxFrequency(_ nums: [Int], _ k: Int) -> Int {
        let nums = nums.sorted()
        let numsCount = nums.count

        var left = 0
        var sum = 0

        for right in 0..<numsCount {
            let value = nums[right]
            sum += value

            // Verify we can make all the values from left to right equal
            // to the current value. Move left pointer otherwise.
            if sum + k < value * (right-left+1) {
                sum -= nums[left]
                left += 1
            }
        }

        return numsCount-left
    }
}
class Solution {
    func maximumScore(_ nums: [Int], _ k: Int) -> Int {
        let n = nums.count
        var left = k
        var right = k
        var answer = nums[k]
        var minValue = nums[k]

        while left > 0 || right < n - 1 {
            // Move towards the side with a larger adjacent element.
            if (left > 0 ? nums[left-1] : 0) > (right < n - 1 ? nums[right+1] : 0) {
                left -= 1
                minValue = min(minValue, nums[left])
            } else {
                right += 1
                minValue = min(minValue, nums[right])
            }
            
            // Update the answer based on the current min value and the width of the window.
            answer = max(answer, minValue * (right - left + 1))
        }

        return answer
    }
}
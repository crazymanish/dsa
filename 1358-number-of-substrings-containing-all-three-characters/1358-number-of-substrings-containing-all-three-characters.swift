class Solution {
    func numberOfSubstrings(_ s: String) -> Int {
        let sArray = Array(s)
        var left = 0
        var right = 0
        var counter = ["a": 0, "b": 0, "c": 0]
        var result = 0

        while right < sArray.count {
            counter[String(sArray[right]), default: 0] += 1 // Increment count of current character

            // Shrink window from left until it no longer contains all characters
            while counter["a", default: 0] > 0 && counter["b", default: 0] > 0 && counter["c", default: 0] > 0 {
                counter[String(sArray[left]), default: 0] -= 1 // Decrement count of leftmost character
                left += 1
            }

            // Add number of valid substrings ending at current right pointer
            result += left

            right += 1
        }

        return result
    }
}
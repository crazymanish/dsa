class Solution {
    func countSubarrays(_ nums: [Int], _ k: Int) -> Int {
        guard let value = nums.max() else { return 0 }
        
        var count = 0
        var answer = 0
        var left = 0 
        
        for right in nums.indices {
            if nums[right] == value {
                count += 1
            }
            
            while count == k {
                if nums[left] == value {
                    count -= 1
                }
                left += 1
            }
            
            answer += left
        }
        
        return answer
    }
}
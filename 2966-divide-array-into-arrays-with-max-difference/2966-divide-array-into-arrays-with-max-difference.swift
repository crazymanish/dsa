class Solution {
    func divideArray(_ nums: [Int], _ k: Int) -> [[Int]] {
        let nums = nums.sorted()
        var result = [[Int]]()
        
        for i in stride(from: 0, through: nums.count-1, by: 3) {
            if nums[i+2] - nums[i] > k {
                return []
            }
            
            var subArray = [Int]()
            subArray.append(nums[i])
            subArray.append(nums[i+1])
            subArray.append(nums[i+2])
            
            result.append(subArray)
        }
        
        return result
    }
}
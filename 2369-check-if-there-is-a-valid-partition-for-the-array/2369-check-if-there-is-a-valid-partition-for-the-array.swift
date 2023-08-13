class Solution {
    func validPartition(_ nums: [Int]) -> Bool {
        var result = false
        var dpCache = Array(repeating: false, count: nums.count)
        
        func checkValidPartition(index: Int) {
            if index > nums.count { return }
            
            if index == nums.count {
                result = true
                return
            }
            
            if dpCache[index] == true { return }
        
            guard index+1 < nums.count else { return }
            
            if nums[index] == nums[index+1] {
                dpCache[index] = true
                checkValidPartition(index: index+2)
            }
        
            guard index+2 < nums.count else { return }
            
            let equalCondition = nums[index] == nums[index+1] && nums[index] == nums[index+2]
            let increaseCondition = nums[index] == (nums[index+1] - 1) && (nums[index] == nums[index+2] - 2)
            
            if equalCondition || increaseCondition {
                dpCache[index] = true
                checkValidPartition(index: index+3)
            }
        }
        
        checkValidPartition(index: 0)
        return result
    }
}
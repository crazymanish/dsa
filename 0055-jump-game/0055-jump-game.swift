class Solution {
    func canJump(_ nums: [Int]) -> Bool {
        if nums.count == 1 { return true }
        
        let destination = nums.count - 1
        var furthest = 0
        var current = 0
    
        while furthest >= current {
            let reach = current + nums[current]
            if reach >= destination { return true }
            
            furthest = max(furthest, reach)
            current += 1
        }
    
        return false
    }
}
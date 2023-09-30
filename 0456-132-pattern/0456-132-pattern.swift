class Solution {
    func find132pattern(_ nums: [Int]) -> Bool {
        var stack = [(min: Int, max: Int)]() // (min, max)

        for i in 0..<nums.count {
            // init stack, push nums[i] as min and max value
	        // or nums[i] is less than min of peek on stack, insert new range.
            if stack.isEmpty || nums[i] < stack.last!.min {
                stack.append((min: nums[i], max: nums[i]))
            } else {
                let currentMin = stack.last!.min
                
                // if we nums[i] is greater or equal to peek max,
                // then we pop peek element on stack
                while !stack.isEmpty && nums[i] >= stack.last!.max {
                    stack.removeLast()
                }
                
                // find 132 pattern
                if !stack.isEmpty && nums[i] > stack.last!.min && nums[i] < stack.last!.max {
                    return true
                }
            
                // update peek on stack
                // 0. update max or
                // 1. insert new range which min value is less than peek's min value on stack
                stack.append((min: currentMin, max: nums[i]))
            }
        }
        
        return false
    }
}
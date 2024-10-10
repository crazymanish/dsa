class Solution {
    func maxWidthRamp(_ nums: [Int]) -> Int {
        var result = 0
        // `stack` is monotonic decreasing stack, storing *indices* of decreasing values 
        var stack = nums.indices.reduce(into: [0]) { stack, i in
            guard nums[stack.last!] > nums[i] else { return }
            stack.append(i)
        }
        
        var j = nums.count-1
		while !stack.isEmpty, j > 0 {
			// greedily consume stack elements that match critera (`nums[i] <= nums[j]`) 
            while let i = stack.last, nums[i] <= nums[j] {
                result = max(result, j - i)
                stack.popLast() // pop b/c this is the max ramp width for `stack.last!`
            }
            
            j -= 1
        }
        
        return result
    }
}
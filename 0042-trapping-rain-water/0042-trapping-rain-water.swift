class Solution {
    func trap(_ height: [Int]) -> Int {
        let count = height.count
        var leftMax = Array(repeating: 0, count: count)
        var rightMax = Array(repeating: 0, count: count)
        var result = 0
        
        leftMax[0] = height[0]
        for index in 1..<count {
            leftMax[index] = max(height[index], leftMax[index - 1])
        }
        
        rightMax[count - 1] = height[count - 1]
        
        for index in stride(from: count - 2, through: 0, by: -1) {
            rightMax[index] = max(height[index], rightMax[index + 1])
        }
        
        for index in 0..<height.count {
            result += min(leftMax[index], rightMax[index]) - height[index]
        }
        
        return result
    }
}

/*
class Solution {
    func trap(_ heights: [Int]) -> Int {
        var stack = [Int]()
        var result = 0
        for (index, item) in heights.enumerated() {
            while !stack.isEmpty && heights[stack.last!] < item {
                let top = heights[stack.popLast()!]
                if stack.isEmpty { break}
                
                let height = min(item, heights[stack.last!]) - top
                let width = index - stack.last! - 1
                result += height * width
            }
            stack.append(index)
        }
        return result
    }
}
*/
class Solution {
    func findDiagonalOrder(_ nums: [[Int]]) -> [Int] {
        var queue: [(Int, Int)] = [(0, 0)]
        var result: [Int] = []
        
        while !queue.isEmpty {
            var nextQueue: [(Int, Int)] = []
            
            for (i, j) in queue {
                if i < nums.count && j < nums[i].count {
                    result.append(nums[i][j])

                    // Do not add the same index.
                    if nextQueue.last?.0 != i+1 {
                        nextQueue.append((i+1, j))
                    }
                    
                    nextQueue.append((i, j+1))
                }   
            }
            
            queue = nextQueue
        }
        
        return result
    }
}
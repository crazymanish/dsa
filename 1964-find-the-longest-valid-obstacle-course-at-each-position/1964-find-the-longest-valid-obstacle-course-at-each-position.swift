class Solution {
    func longestObstacleCourseAtEachPosition(_ obstacles: [Int]) -> [Int] {
        let obstaclesCount = obstacles.count
        var currentLength = 0
        var answers: [Int] = Array(repeating: 0, count: obstaclesCount)
        var dpCache: [Int] = Array(repeating: Int.max, count: obstaclesCount)
        dpCache[0] = Int.min
        
        for index in 0..<obstaclesCount {
            var left = 0
            var right = currentLength
            
            while left < right {
                let mid = left+(right-left)/2
                
                if dpCache[mid] <= obstacles[index] {
                    left = mid+1
                } else {
                    right = mid
                }
            }
            
            answers[index] = left+1
            
            if currentLength == left { currentLength += 1 }
            
            dpCache[left] = obstacles[index]
        }
        
        return answers
    }
}
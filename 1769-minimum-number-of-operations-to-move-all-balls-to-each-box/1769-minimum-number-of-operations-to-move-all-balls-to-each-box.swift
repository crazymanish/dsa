class Solution {
    func minOperations(_ boxes: String) -> [Int] {
        let n = boxes.count
        var answer = [Int](repeating: 0, count: n)
        let boxesArray = Array(boxes)
    
        // Arrays to keep track of operations from left and right
        var leftOperations = [Int](repeating: 0, count: n)
        var rightOperations = [Int](repeating: 0, count: n)
    
        // Calculate left operations
        var balls = 0
        var operations = 0
        for i in 0..<n {
            // Store the current number of operations needed from the left
            leftOperations[i] = operations
            // If the current box has a ball, increment the ball count
            if boxesArray[i] == "1" {
                balls += 1
            }
            // Increment the operations by the number of balls encountered so far
            operations += balls
        }
    
        // Calculate right operations
        balls = 0
        operations = 0
        for i in (0..<n).reversed() {
            // Store the current number of operations needed from the right
            rightOperations[i] = operations
            // If the current box has a ball, increment the ball count
            if boxesArray[i] == "1" {
                balls += 1
            }
            // Increment the operations by the number of balls encountered so far
            operations += balls
        }
    
        // Combine left and right operations to get the final answer
        for i in 0..<n {
            answer[i] = leftOperations[i] + rightOperations[i]
        }
    
        return answer
    }
}
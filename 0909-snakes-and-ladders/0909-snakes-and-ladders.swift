/*
Create a hashmap to store the board
Create a queue to store the current point
Create a hashset to store the visited point
Add 1 to the queue and hashset
Create a step to store the current step.
While the queue is not empty
Get the size of the queue
For each element in the queue
Get the current point
If the current point is the last point, return the step
For each point from 1 to 6
Get the new point
If the new point is greater than the last point, continue
If the new point is not -1, get the new point from the hashmap
If the new point is not in the hashset, add the new point to the queue and hashset
Add 1 to the step
Return -1
*/
class Solution {
    func snakesAndLadders(_ board: [[Int]]) -> Int {
        let n = board.count
        let finalPosition = n * n
        var boardHashMap: [Int : Int] = [:]
        var start = finalPosition
        
        for i in 0..<n {
            for j in 0..<n{
                if ((n-i) % 2 == 0) {
                   boardHashMap[start] = board[i][j]
                } else {
                   boardHashMap[start] = board[i][n - j - 1]
                }
                start -= 1
            }
        }
        
        var stepRequired = 0
        var queue = [Int]()
        var visitedPositions = Set<Int>()
        queue.append(1)
        visitedPositions.insert(1)
        
        while queue.isEmpty == false {
            let size = queue.count
            
            for _ in 0..<size {
                let currentPosition = queue.removeFirst()
                if (currentPosition == finalPosition)  { return stepRequired } // we reached n2
                
                for j in 1...6 {
                    var newPosition = currentPosition + j
                    if (newPosition > finalPosition) { continue }
                    
                    if(boardHashMap[newPosition] != -1){
                        newPosition = boardHashMap[newPosition]!
                    }
                    
                    if(visitedPositions.contains(newPosition) == false){
                        queue.append(newPosition)
                        visitedPositions.insert(newPosition)
                    }
                }
            }
            
            stepRequired += 1
        }
        
        return -1
    }
}
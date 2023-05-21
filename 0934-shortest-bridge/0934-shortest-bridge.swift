/*
Step 1 is to find all islands.
Step 2 is to BFS each island until it connects to another island
Keep track of min
*/
class Solution {
    func shortestBridge(_ grid: [[Int]]) -> Int {
        let directions: [[Int]] = [[1, 0], [0, 1], [-1, 0], [0,-1]]
        
        // Returns a 3d Array of all coordinates for each island. 
        // Each element in the array represents all the coordinates that form that island. 
	    // example: [Island, Island]
	    // Island = [[x,y],[x,y]..] pairs
        func getAllIslands() -> [[[Int]]] {
            var islands: [[[Int]]] = []
            var coordinates: [[Int]] = []
            var grid = grid
            
            // helper for function above. 
            func dfs(_ i: Int, _ j: Int) {    
                guard i>=0, j>=0, i<grid.count, j<grid[0].count else { return }
       
                if grid[i][j] == 0 { return }
                
                grid[i][j] = 0  // Mark as visited 
                coordinates.append([i, j])
                for direction in directions { 
                    let newX = i + direction[0]
                    let newY = j + direction[1]
                    dfs(newX, newY)
                }
            }
        
            for i in 0..<grid.count {
                for j in 0..<grid[i].count { 
                    if grid[i][j] == 1 { 
                        coordinates = []
                        dfs(i, j) 
                        islands.append(coordinates)
                    }
                }
            }
            
            return islands
        }
        
        // Takes in one island and finds its shortest bridge using BFS. Do this for all islands and keep track of minimum
        func findMinimumBridge(_ island: [[Int]]) -> Int { 
            var seen = Set<[Int]>()
            var queue: [[Int]] = []
        
            for coord in island { 
                queue.append(coord)
                seen.insert(coord)
            }
        
            var minimum = 0
        
            while !queue.isEmpty {
                let size = queue.count

                for _ in 0..<size {
                    let current = queue.removeFirst()    
                
                    for direction in directions {
                        let newX = current[0] + direction[0]
                        let newY = current[1] + direction[1]
                    
                        guard newX>=0, newY>=0, newX<grid.count, newY<grid[0].count && !seen.contains([newX, newY]) else { continue }
                    
                        if grid[newX][newY] == 1 {
                            return minimum
                        } 
                        seen.insert([newX, newY])
                        queue.append([newX, newY])
                    }    
                } 
                minimum += 1
            }
            
            return -1
        }
        
        var result = Int.max
        for island in getAllIslands() {
            result = min(findMinimumBridge(island), result)
        }
        
        return result
    }
}
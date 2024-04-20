final class Solution {
    func findFarmland(_ land: [[Int]]) -> [[Int]] {
        var coordinates: [[Int]] = []
        var land = land // to be able to mutate
        var bottomRight: [Int] = []
        
        func explore(_ i: Int, _ j: Int) {
            //checking for out of bounds
            guard i >= 0, j >= 0, i < land.count, j < land[i].count, land[i][j] == 1 else { return }
        
            land[i][j] = 0 // mark as visited
        
            if i > bottomRight[0] { bottomRight[0] = i } // updating
            if j > bottomRight[1] { bottomRight[1] = j } // bottom right
        
            explore(i-1, j) // top
            explore(i+1, j) // bottom
            explore(i, j-1) // left
            explore(i, j+1) // right
        }
        
        for i in 0..<land.count {
            for j in 0..<land[i].count where land[i][j] == 1{
                bottomRight = [i, j]
                explore(i, j)
                
                let topLeft = [i, j]
                coordinates.append(topLeft + bottomRight)
            }
        }
        
        return coordinates
    }
}
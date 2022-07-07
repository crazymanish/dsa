// https://leetcode.com/problems/island-perimeter

class Solution {
    func islandPerimeter(_ grid: [[Int]]) -> Int {
        /*
        Logic:
        1. loop over the matrix and count the number of islands;
        2. if the current dot is an island, count if it has any right neighbour or down neighbour;
        3. the result is islands * 4 - neighbours * 2
        */
        
        var islands = 0
        var neighbours = 0
        
        let lastRowIndex = grid.count-1
        let lastColumnIndex = grid[0].count-1
        
        for rowIndex in 0...lastRowIndex {
            for columnIndex in 0...lastColumnIndex {
                if grid[rowIndex][columnIndex] == 1 { 
                    islands += 1 // Found island
                    
                    // Check for right neighbour
                    if columnIndex+1 <= lastColumnIndex && grid[rowIndex][columnIndex+1] == 1 {
                        neighbours += 1 // Found island in right neighbour also
                    }
                    
                    // Check for down neighbour
                    if rowIndex+1 <= lastRowIndex && grid[rowIndex+1][columnIndex] == 1 {
                        neighbours += 1 // Found island in down neighbour also
                    }
                } 
            }
        }
        
        return islands * 4 - neighbours * 2
    }
}
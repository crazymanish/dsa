class Solution {
    func getMaximumGold(_ grid: [[Int]]) -> Int {
	    var grid = grid 
	    var best = 0 

	    // Search helper method (DFS)
	    func search(_ row: Int, _ col: Int, _ sum: Int) {
		    var sum = sum + grid[row][col]
		    let temp = grid[row][col]
		    grid[row][col] = 0
		    best = max(best, sum)

		    if row > 0, grid[row-1][col] != 0 {
			    search(row-1, col, sum)
		    }
		
            if row+1 < grid.count, grid[row+1][col] != 0 {
			    search(row+1, col, sum)
		    }
		
            if col > 0, grid[row][col-1] != 0 {
			    search(row, col-1, sum)
		    }
		
            if col+1 < grid[0].count, grid[row][col+1] != 0 {
			    search(row, col+1, sum)
		    }

		    grid[row][col] = temp
	    }

	    // Explore each starting pointer 
	    for row in 0 ..< grid.count {
		    for col in 0 ..< grid[row].count {
			    if grid[row][col] != 0 {
				    search(row, col, 0)
			    }
		    }
	    }

	    return best
    }
}
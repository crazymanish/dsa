class Solution {
    func knightProbability(_ n: Int, _ k: Int, _ row: Int, _ column: Int) -> Double {
        let directions = [[-1,-2], [-2,-1], [-2,1], [-1,2], [1,-2], [2,-1], [2,1], [1,2]]
        var dp = Array(repeating: Array(repeating: Array<Double>(repeating: 0.0, count: n), count: n), count: k+1)
     
        func findProbability(_ k: Int, _ row: Int, _ column: Int) -> Double {
            guard row >= 0, row < n, column >= 0, column < n else { return 0 }

            guard k != 0 else { return 1 }

            if dp[k][row][column] != 0 { return dp[k][row][column] }

            var result = 0.0
            for direction in directions {
                result += findProbability(k-1, row+direction[0], column+direction[1])/8
            }
            
            dp[k][row][column] = result
            return dp[k][row][column]
        }
        
        return findProbability(k, row, column)
    }
}
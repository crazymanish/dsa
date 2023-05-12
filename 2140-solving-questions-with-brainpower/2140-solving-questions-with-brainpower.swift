class Solution {
    func mostPoints(_ questions: [[Int]]) -> Int {
        let n = questions.count
        
        guard n > 1 else { return questions[0][0] }
        
        // set up an array to store the points for dynamic programming 
        // and write down the points you get for completing the last question
        var pointsTable = Array(repeating: 0, count: n)
        pointsTable[n-1] = questions[n-1][0]
        
        // read backwards through the questions, 
        // keeping track of the max number of points you can get if you start at problem i
        for k in 0...n-2 {
            let i = n-2-k
            
            // the points you get if you skip question i
            var skipScore = pointsTable[i+1]
            
            // the points you get if you do question i
            let l = questions[i][1]
            var useScore = questions[i][0] + (l+i+1 > n-1 ? 0 : pointsTable[i+l+1])
            
            // save the score for the better of the two options
            pointsTable[i] = max(skipScore, useScore)
            
        }
        
        // start at the beginning!
        return pointsTable[0]
    }
}
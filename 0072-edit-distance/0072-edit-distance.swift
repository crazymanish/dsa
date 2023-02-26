class Solution {
    func minDistance(_ word1: String, _ word2: String) -> Int {
        let word1Array = Array(word1) 
        let word2Array = Array(word2) 
        let rows = word1Array.count + 1
        let columns = word2Array.count + 1
        
        var dpCache = [[Int]](repeating: [Int](repeating: Int.max, count: columns), count: rows)
        
        // populate base cases
        for row in 0..<rows { dpCache[row][0] = row }
        for column in 0..<columns { dpCache[0][column] = column }
        
        // populate the rest
        for row in 1..<rows {
            for column in 1..<columns {
                let insertionCost = dpCache[row-1][column] + 1
                let deletionCost = dpCache[row][column-1] + 1
                let matchSubstitutionCost = dpCache[row-1][column-1] + (word1Array[row-1] != word2Array[column-1] ? 1 : 0)
                
                dpCache[row][column] = min(insertionCost, min(deletionCost, matchSubstitutionCost))
            }
        }
        
        return dpCache[rows-1][columns-1]
    }
}
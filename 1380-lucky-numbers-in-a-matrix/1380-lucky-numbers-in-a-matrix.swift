class Solution {
    func luckyNumbers (_ matrix: [[Int]]) -> [Int] {
        let rows = matrix.count
        var lucky = [Int]()
        
        for row in 0..<rows {
            guard let min = matrix[row].min(),
                  let column = matrix[row].firstIndex(of: min),
                  let max = matrix.map({ $0[column] }).max(),
                  min == max else {
                continue
            }
            
            lucky.append(min)
        }
        
        return lucky
    }
}
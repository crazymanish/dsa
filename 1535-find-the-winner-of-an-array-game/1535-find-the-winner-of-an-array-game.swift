class Solution {
    func getWinner(_ arr: [Int], _ k: Int) -> Int {
        let n = arr.count
        
        guard k < n else { return arr.max()! }
        
        var roundRemains = k
        var winner = arr[0]
        
        for i in 1..<n {
            if arr[i] > winner {
                roundRemains = k
                winner = arr[i]
            }
            
            roundRemains -= 1
            if roundRemains == 0 { break }
        }
        
        return winner
    }
}
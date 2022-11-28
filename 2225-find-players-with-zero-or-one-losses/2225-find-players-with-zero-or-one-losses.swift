class Solution {
    func findWinners(_ matches: [[Int]]) -> [[Int]] {
        var winners = [Int: Int]()
        var losers = [Int: Int]()
        
        for match in matches {
            let winner = match[0]
            let loser = match[1]
            
            if let winCount = winners[winner] {
                winners[winner] = winCount + 1
            } else {
                winners[winner] = 1
            }
        
            if let loseCount = losers[loser] {
                losers[loser] = loseCount + 1
            } else {
                losers[loser] = 1
            }
        }
    
        for loser in losers.keys {
            if winners[loser] != nil {
                winners.removeValue(forKey: loser)
            }
        }
    
        for loser in losers.keys {
            if winners[loser] != nil {
                winners.removeValue(forKey: loser)
            }
            
            if losers[loser]! > 1 {
                losers.removeValue(forKey: loser)
            }
        }
    
        for winner in winners.keys {
            if losers[winner] != nil {
                losers.removeValue(forKey: winner)
            }
        }
 
        return [Array(winners.keys).sorted(), Array(losers.keys).sorted()]
    } 
    /*
    func findWinners(_ matches: [[Int]]) -> [[Int]] {
        var losers = [Int:Int]()
        var outputWin = [Int]()
        var outputLose = [Int]()

        matches.forEach {
            if !losers.keys.contains($0[0]) {
                losers[$0[0]] = 0
            }
            
            if losers.keys.contains($0[1]) {
                let num = losers[$0[1]]!
                losers[$0[1]] = num + 1
            } else {
                losers[$0[1]] = 1
            }
        }

        for (key,value) in losers {
            if value == 0 {
                outputWin.append(key)
            } else if value == 1 {
                outputLose.append(key)
            }
        }

        return [outputWin.sorted(), outputLose.sorted()]
    } */
}
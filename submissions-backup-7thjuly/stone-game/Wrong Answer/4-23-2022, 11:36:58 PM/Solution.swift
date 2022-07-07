// https://leetcode.com/problems/stone-game

class Solution {
    func stoneGame(_ piles: [Int]) -> Bool {
        var aliceStonesSum = 0
        var bobStonesSum = 0
        
        func playStoneGame(_ startIndex: Int, _ endIndex: Int, _ isAlice: Bool) {
            if startIndex > endIndex { return }
            
            if piles[startIndex] > piles[endIndex] {
                updateSum(startIndex, isAlice)
                playStoneGame(startIndex+1, endIndex, !isAlice)
            } else {
                updateSum(endIndex, isAlice)
                playStoneGame(startIndex, endIndex-1, !isAlice)
            }
        }
        
        func updateSum(_ index: Int, _ isAlice: Bool) {
            if isAlice {
                aliceStonesSum += piles[index]
            } else {
                bobStonesSum += piles[index]
            }
        }
        
        playStoneGame(0, (piles.count-1), true)
        return aliceStonesSum > bobStonesSum
    }
}
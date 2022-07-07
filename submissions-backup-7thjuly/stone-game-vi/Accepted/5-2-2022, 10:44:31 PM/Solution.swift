// https://leetcode.com/problems/stone-game-vi

class Solution {
    func stoneGameVI(_ aliceValues: [Int], _ bobValues: [Int]) -> Int {
        class StoneInfo {
            let index: Int
            let value: Int
            
            init(index: Int, value: Int) {
                self.index = index
                self.value = value
            }
        }
        
        var stoneInfos: [StoneInfo] = []
        for index in 0..<aliceValues.count {
            let value = aliceValues[index] + bobValues[index]
            let stoneInfo = StoneInfo(index: index, value: value)
            stoneInfos.append(stoneInfo)
        }
        
        stoneInfos = stoneInfos.sorted { $0.value > $1.value } // sorted by value
        
        var aliceScore = 0
        var bobScore = 0
        for (index, stoneInfo) in stoneInfos.enumerated() {
            if index % 2 == 0 { // Alice will start game, so all EVEN index value will go-to Alice i.e 0, 2, 4...
                aliceScore += aliceValues[stoneInfo.index]
            } else {
                bobScore += bobValues[stoneInfo.index] // all ODD index value for Bob i.e 1, 3, 5...
            }
        }
        
        if aliceScore > bobScore { return 1 }
        if bobScore > aliceScore { return -1 }
        
        return 0 // DRAW \U0001f608
    }
}
class Solution {
    func maximumHappinessSum(_ happiness: [Int], _ k: Int) -> Int {
        var happiness = happiness.sorted(by: >)
        var maxHappinessSum = 0
        
        for i in 0..<k {
            let maxHappiness = max(0, happiness[i] - i)
            maxHappinessSum += maxHappiness
        }
        
        return maxHappinessSum
    }
}
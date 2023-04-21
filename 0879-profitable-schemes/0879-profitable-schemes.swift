class Solution {
    func profitableSchemes(_ n: Int, _ minProfit: Int, _ group: [Int], _ profit: [Int]) -> Int {
        let mod = 1000000007
        var dpCache = Array(repeating: Array(repeating: 0, count: minProfit+1), count: n+1)
        dpCache[0][0] = 1
        
        for i in 0..<group.count {
            let currentGroup = group[i]
            let currentProfit = profit[i]
            for groupIndex in stride(from: n, through: currentGroup, by: -1) {
                for profitIndex in stride(from: minProfit, through: 0, by: -1) {
                    dpCache[groupIndex][profitIndex] = (
                        dpCache[groupIndex][profitIndex] + 
                        dpCache[groupIndex-currentGroup][max(0, profitIndex-currentProfit)]
                    ) % mod
                }
            }
        }
        
        var profitableSchemes = 0
        for groupIndex in 0...n {
            profitableSchemes = (profitableSchemes + dpCache[groupIndex][minProfit]) % mod
        }
        
        return profitableSchemes
    }
}
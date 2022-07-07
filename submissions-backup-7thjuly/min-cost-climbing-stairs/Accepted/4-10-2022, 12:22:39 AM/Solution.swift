// https://leetcode.com/problems/min-cost-climbing-stairs

class Solution {
    func minCostClimbingStairs(_ cost: [Int]) -> Int {
        var costs = cost
        costs.append(0) // User input array itself for DP cache
        
        for index in (0..<costs.count-2).reversed() {
            costs[index] += min(costs[index+1], costs[index+2])
        }
        
        return min(costs[0], costs[1])
    }
}
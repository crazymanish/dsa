class Solution {
    func maxSatisfaction(_ satisfaction: [Int]) -> Int {
        let sortedSatisfactions = satisfaction.sorted(by: >)
        
        var prefixSum = 0
        var currentSatisfaction = 0
        var maxSatisfaction = 0
        
        for satisfaction in sortedSatisfactions {
            prefixSum += satisfaction
            currentSatisfaction += prefixSum
            maxSatisfaction = max(maxSatisfaction, currentSatisfaction)
        }
        
        return maxSatisfaction
    }
}
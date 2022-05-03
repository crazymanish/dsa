class Solution {
    func mincostTickets(_ days: [Int], _ costs: [Int]) -> Int {
        let daysCount = days.count
        var dpCache = Array(repeating: -1, count: daysCount)
        
        func findMinCostUsingDFSForDayIndex(_ index: Int) -> Int {
            if index >= daysCount { return 0 }
            
            if dpCache[index] != -1 { return dpCache[index] }
            
            // We have 3 choices
            // 1 day pass - costs[0]
            // 7 days pass - costs[1]
            // 30 days pass - costs[3]
            
            let Day1PassAnswer = costs[0] + findMinCostUsingDFSForDayIndex(index+1)
            
            var newIndex = index
            while newIndex < daysCount && days[newIndex] < days[index]+7 {
                newIndex += 1
            }
            let Day7PassAnswer = costs[1] + findMinCostUsingDFSForDayIndex(newIndex)
            
            newIndex = index
            while newIndex < daysCount && days[newIndex] < days[index]+30 {
                newIndex += 1
            }
            let Day30PassAnswer = costs[2] + findMinCostUsingDFSForDayIndex(newIndex)
            
            var minimumCost = min(Day1PassAnswer, Day7PassAnswer)
            minimumCost = min(minimumCost, Day30PassAnswer)
            
            dpCache[index] = minimumCost
            return minimumCost
        }
        
        return findMinCostUsingDFSForDayIndex(0)
    }
}
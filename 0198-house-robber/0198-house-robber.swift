class Solution {
    func rob(_ nums: [Int]) -> Int {
        var dpCache = Array(repeating: -1, count: nums.count)
        
        for (currentHouseIndex, currentHouseMoney) in nums.enumerated() {
            var previousHouseMoney = 0
            if currentHouseIndex-1 >= 0 { previousHouseMoney = dpCache[currentHouseIndex-1] }
            
            var previousPreviousHouseMoney = 0
            if currentHouseIndex-2 >= 0 { previousPreviousHouseMoney = dpCache[currentHouseIndex-2] }
            
            let maxRobMoney = max(currentHouseMoney+previousPreviousHouseMoney, previousHouseMoney)
            dpCache[currentHouseIndex] = maxRobMoney
        }
        
        return dpCache.last!
    }
}
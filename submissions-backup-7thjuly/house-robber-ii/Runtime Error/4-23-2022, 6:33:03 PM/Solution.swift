// https://leetcode.com/problems/house-robber-ii

class Solution {
    func rob(_ nums: [Int]) -> Int {
        let houseCount = nums.count
        
        if houseCount <= 2 { return 0 } // Police will come if try to rob 1 house or 2 house
        
        var dpCache = Array(repeating: -1, count: houseCount)
        dpCache[0] = nums[0]
        dpCache[1] = nums[1]
        
        for (currentHouseIndex, currentHouseMoney) in nums.enumerated() {
            let previousHouseMoney = dpCache[currentHouseIndex-1]
            let previousPreviousHouseMoney = dpCache[currentHouseIndex-2]
            
            let maxRobMoney: Int
            if currentHouseIndex+1 == houseCount && houseCount % 2 != 0 { // last house with ODD count
                maxRobMoney = max(currentHouseMoney-nums[0]+previousPreviousHouseMoney, previousHouseMoney)
            } else {
                maxRobMoney = max(currentHouseMoney+previousPreviousHouseMoney, previousHouseMoney)
            }
            
            dpCache[currentHouseIndex] = maxRobMoney
        }
        
        return dpCache.last!
    }
}

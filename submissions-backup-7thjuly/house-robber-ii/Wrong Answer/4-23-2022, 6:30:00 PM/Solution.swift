// https://leetcode.com/problems/house-robber-ii

class Solution {
    // Just one if condition extenstion of previous problem
    // 198. House Robber
    // https://leetcode.com/problems/house-robber/
    func rob(_ nums: [Int]) -> Int {
        let houseCount = nums.count
        var dpCache = Array(repeating: -1, count: houseCount)
        
        for (currentHouseIndex, currentHouseMoney) in nums.enumerated() {
            var previousHouseMoney = 0
            if currentHouseIndex-1 >= 0 { previousHouseMoney = dpCache[currentHouseIndex-1] }
            
            var previousPreviousHouseMoney = 0
            if currentHouseIndex-2 >= 0 { previousPreviousHouseMoney = dpCache[currentHouseIndex-2] }
            
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

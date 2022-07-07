// https://leetcode.com/problems/house-robber-ii

class Solution {
    func rob(_ nums: [Int]) -> Int {
        let houseCount = nums.count
        
        if houseCount == 1 { return nums[0] }
        
        /*
        We can divide this problem to two sub problems:
        Subproblem 1: rob house index-0 <-to-> second-last index 
        Subproblem 2: rob house index-1 <-to-> last index 
        And find the bigger one of these two sub problems.
        */
        let robWithHouse0 = rob(nums, 0, nums.count-2)
        let robWithHouse1 = rob(nums, 1, nums.count-1)
        
        return max(robWithHouse0, robWithHouse1)
    }

    // Almost same code of: 198. House Robber
    // https://leetcode.com/problems/house-robber/
    func rob(_ nums: [Int], _ startIndex: Int, _ endIndex: Int) -> Int {
        var dpCache = Array(repeating: 0, count: nums.count)
        var currentHouseIndex = startIndex
        
        while currentHouseIndex <= endIndex {
            let currentHouseMoney = nums[currentHouseIndex]
            
            var previousHouseMoney = 0
            if currentHouseIndex-1 >= 0 { previousHouseMoney = dpCache[currentHouseIndex-1] }
            
            var previousPreviousHouseMoney = 0
            if currentHouseIndex-2 >= 0 { previousPreviousHouseMoney = dpCache[currentHouseIndex-2] }
            
            let maxRobMoney = max(currentHouseMoney+previousPreviousHouseMoney, previousHouseMoney)
            dpCache[currentHouseIndex] = maxRobMoney
            
            currentHouseIndex += 1
        }
        
        return dpCache[endIndex]
    }
}
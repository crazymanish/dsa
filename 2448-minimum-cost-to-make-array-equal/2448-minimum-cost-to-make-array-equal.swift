/*
Approach: Find the median, deviation from there is always minimum!
Complexity
- Time complexity: O(nlog(n))
- Space complexity: O(n)
*/
class Solution {
    // Logic: find weighted median...
    func minCost(_ nums: [Int], _ cost: [Int]) -> Int {
        var array = [(val: Int, cost: Int)]()
        var totalCost = 0
        for i in 0 ..< nums.count {
            array.append((val: nums[i], cost: cost[i]))
            totalCost += cost[i]
        }
        
        // Median works with sorted Elements!
        array.sort{ $0.val < $1.val }

        // finding the median...
        var median = -1
        var currentCost = 0
        var currentIndex = 0
        while currentCost < (totalCost + 1) / 2 && currentIndex < nums.count {
            median = array[currentIndex].val
            currentCost += array[currentIndex].cost
            currentIndex += 1
        }

        // just calculate the cost now
        var minCost = 0
        for element in array {
            minCost += (abs(element.val - median) * element.cost)
        }
        
        return minCost
    }
}
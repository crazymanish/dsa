// https://leetcode.com/problems/richest-customer-wealth

class Solution {
    func maximumWealth(_ accounts: [[Int]]) -> Int {
        var maxWealth = Int.min
        
        for account in accounts {
            var currentWealth = 0
            for money in account {
                currentWealth += money
            }
            maxWealth = max(maxWealth, currentWealth)
        }
        
        return maxWealth
    }
}
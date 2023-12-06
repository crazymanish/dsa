class Solution {
    func totalMoney(_ n: Int) -> Int {
        let fullWeeks = n / 7
        let lastWeekDays = n % 7
    
        let fullWeeksMoney = (56 + 7 * (fullWeeks - 1)) * fullWeeks / 2
        let lastWeekMoney = (2 * fullWeeks + lastWeekDays + 1) * lastWeekDays / 2
        
        return fullWeeksMoney + lastWeekMoney
    }
}
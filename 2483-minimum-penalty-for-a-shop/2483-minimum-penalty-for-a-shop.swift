/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • O(n), where n = customers.count
///     We scan the string once.
///
/// Space Complexity:
///   • O(1)
///     Only a few integer counters are used.
///
/// Problem Summary:
///   We want to choose the best hour to close the shop to minimize penalty:
///     - If we are OPEN and a customer is 'N' → penalty +1
///     - If we are CLOSED and a customer is 'Y' → penalty +1
///
/// Approach:
///   - Start with closing at hour 0 (closed all day).
///     Penalty = total number of 'Y' customers.
///   - Move the closing time hour by hour:
///       • Passing a 'Y' reduces penalty by 1 (now served while open)
///       • Passing an 'N' increases penalty by 1 (open unnecessarily)
///   - Track the minimum penalty and the earliest hour achieving it.
/// ---------------------------------------------------------------------------

class Solution {
    func bestClosingTime(_ customers: String) -> Int {
        let customerArray = Array(customers)
        
        // Penalty if we close at hour 0: all 'Y' customers are missed
        var currentPenalty = customerArray.filter { $0 == "Y" }.count
        
        var minimumPenalty = currentPenalty
        var bestHour = 0
        
        // Move closing time from hour 1 to n
        for hour in 0..<customerArray.count {
            if customerArray[hour] == "Y" {
                // This customer is now served (no longer missed)
                currentPenalty -= 1
            } else {
                // This hour is open but no customer came
                currentPenalty += 1
            }
            
            // Update best (earliest) closing time if penalty improves
            if currentPenalty < minimumPenalty {
                minimumPenalty = currentPenalty
                bestHour = hour + 1
            }
        }
        
        return bestHour
    }
}

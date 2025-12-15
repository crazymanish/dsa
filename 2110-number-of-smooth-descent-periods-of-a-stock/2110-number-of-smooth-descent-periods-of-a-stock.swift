class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(n), where n = prices.count
    ///     We scan the list once while maintaining a sliding count.
    ///
    /// Space Complexity:
    ///   • O(1)
    ///     Only a couple of integer counters are used.
    ///
    /// Explanation:
    ///   A "descent period" ends at index i if prices continuously decrease by 1:
    ///
    ///       prices[i] == prices[i-1] - 1
    ///
    ///   If so:
    ///       currentStreak += 1
    ///   else:
    ///       currentStreak = 1   (start new period)
    ///
    ///   Every element contributes `currentStreak` descent periods ending at i.
    ///   Summing all streaks gives the total number of descent periods.
    /// -----------------------------------------------------------------------
    func getDescentPeriods(_ prices: [Int]) -> Int {
        let n = prices.count
        if n == 0 { return 0 }  // Safeguard
        
        var totalPeriods = 1        // Every single element is a period
        var currentStreak = 1       // Length of current valid descending streak
        
        for i in 1..<n {
            if prices[i] == prices[i - 1] - 1 {
                currentStreak += 1
            } else {
                currentStreak = 1
            }
            
            totalPeriods += currentStreak
        }
        
        return totalPeriods
    }
}

class Solution {
    func longestSquareStreak(_ nums: [Int]) -> Int {
        let s = Set(nums)
        var maxStreak = -1
        
        for var n in s where s.contains(n*n) {
            var streak = 0
            
            while s.contains(n) {
                n = n*n
                streak += 1
            }
            
            maxStreak = max(maxStreak, streak)
        }
        
        return maxStreak
    }
}